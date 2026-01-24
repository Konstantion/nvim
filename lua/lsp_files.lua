local M = {}
local lsp = vim.lsp

local willRename = "workspace/willRenameFiles"
local didRename = "workspace/didRenameFiles"
local willDelete = "workspace/willDeleteFiles"
local didDelete = "workspace/didDeleteFiles"

local function log(msg, level)
	local to_use = level or vim.log.levels.INFO
	vim.notify(msg, to_use)
end

local function get_uris_from_edit(workspace_edit)
	local uris = {}

	if workspace_edit.changes then
		for uri, _ in pairs(workspace_edit.changes) do
			uris[uri] = true
		end
	end

	if workspace_edit.documentChanges then
		for _, change in ipairs(workspace_edit.documentChanges) do
			if change.textDocument then
				uris[change.textDocument.uri] = true
			end
		end
	end

	log("uris: " .. vim.inspect(uris))

	return uris
end

function M.does_support()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = lsp.get_clients({ bufnr = bufnr })

	local function supports(client, method)
		if client.supports_method(method) then
			log("LSP client " .. client.name .. " supports " .. method)
		end
	end

	for _, client in pairs(clients) do
		supports(client, willRename)
		supports(client, didRename)
		supports(client, willDelete)
		supports(client, didDelete)
	end
end

local function request_changes(method, params, prompt_title)
	local clients = lsp.get_clients()
	-- log("LSP Debug: Found " .. #clients .. " attached clients.")

	for _, client in pairs(clients) do
		if lsp.client.supports_method(client, method) then
			log("Requesting " .. prompt_title .. " from LSP client " .. client.name)

			local response = lsp.client.request_sync(client, method, params, 2000, 0)

			if response and response.result then
				lsp.util.apply_workspace_edit(response.result, client.offset_encoding)
				log(prompt_title .. " applied from LSP client " .. client.name)

				local uris = get_uris_from_edit(response.result)
				for uri, _ in pairs(uris) do
					local bufnr = vim.uri_to_bufnr(uri)
					if vim.api.nvim_buf_is_valid(bufnr) then
						vim.fn.bufload(bufnr)
						vim.api.nvim_buf_call(bufnr, function()
							vim.cmd("update")
						end)
						-- log("Autosaved: " .. uri)
					end
				end
			else
				-- log("LSP client " .. client.name .. " returned no edits.")
			end
		else
			-- log("Skip: " .. client.name .. " does not support " .. method, vim.log.levels.WARN)
		end
	end
end

local function notify_clients(method, params)
	local clients = lsp.get_clients()
	for _, client in pairs(clients) do
		if lsp.client.supports_method(client, method) then
			client.notify(method, params)
		end
	end
end

function M.move_file(source, target)
	local old_uri = vim.uri_from_fname(source)
	local new_uri = vim.uri_from_fname(target)

	local params = {
		files = {
			{
				oldUri = old_uri,
				newUri = new_uri,
			},
		},
	}

	request_changes(willRename, params, "Moving File")

	local new_dir = vim.fn.fnamemodify(target, ":h")
	vim.fn.mkdir(new_dir, "p")

	local success, err = os.rename(source, target)
	if not success then
		log("Failed to move file: " .. err, vim.log.levels.ERROR)
		return
	end

	notify_clients(didRename, params)

	local current_buf = vim.api.nvim_get_current_buf()
	local current_buf_name = vim.api.nvim_buf_get_name(current_buf)

	if current_buf_name == source then
		vim.cmd.file(target)
		vim.cmd.e()
	end

	log("Moved: " .. vim.fn.fnamemodify(source, ":t") .. " -> " .. vim.fn.fnamemodify(target, ":t"))
end

function M.delete_file(path)
	local uri = vim.uri_from_fname(path)
	local params = { files = { { uri = uri } } }

	request_changes(willDelete, params, "Deleting File")

	local success, err = os.remove(path)
	if not success then
		log("Failed to delete file: " .. err, vim.log.levels.ERROR)
		return
	end

	notify_clients(didDelete, params)

	local current_buf = vim.api.nvim_get_current_buf()
	if vim.api.nvim_buf_get_name(current_buf) == path then
		vim.cmd("bdelete!")
	end

	log("Deleted: " .. vim.fn.fnamemodify(path, ":t"))
end

function M.rename_current_buffer()
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		return log("Buffer has no name")
	end

	vim.ui.input({
		prompt = "New path: ",
		completion = "file",
		default = current_file,
	}, function(input)
		if input and input ~= "" and input ~= current_file then
			M.move_file(current_file, input)
		end
	end)
end

function M.delete_current_buffer()
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		return log("Buffer has no name")
	end

	vim.ui.select({ "Yes", "No" }, {
		prompt = "Delete file " .. vim.fn.fnamemodify(current_file, ":t") .. "?",
	}, function(choice)
		if choice == "Yes" then
			M.delete_file(current_file)
		end
	end)
end

_G.lsp_files = M
return M
