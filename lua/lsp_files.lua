local M = {}
local lsp = vim.lsp

local willRename = "workspace/willRenameFiles"
local didRename = "workspace/didRenameFiles"
local willDelete = "workspace/willDeleteFiles"
local didDelete = "workspace/didDeleteFiles"

function M.does_support()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = lsp.get_clients({ bufnr = bufnr })
	local function supports(client, method)
		if lsp.client.supports_method(client, method) then
			print("LSP client " .. client.name .. " supports " .. method)
		end
	end

	for _, client in pairs(clients) do
		supports(client, willRename)
		supports(client, didRename)
		supports(client, willDelete)
		supports(client, didDelete)
	end
end

local function request_changes(method, params, promt_title)
	local clients = lsp.get_clients()
	for _, client in pairs(clients) do
		if lsp.client.supports_method(client, method) then
			print("Requesting " .. promt_title .. " from LSP client " .. client.name)
			local response = lsp.client.request_sync(client, method, params, 1000, 0)
			if response and response.result then
				lsp.util.apply_workspace_edit(response.result, client.offset_encoding)
				print(promt_title .. " applied from LSP client " .. client.name)
			end
		end
	end
end

local function notify_clients(method, params)
	local clients = lsp.get_clients()
	for _, client in pairs(clients) do
		if lsp.client.supports_method(client, method) then
			lsp.client.notify(client, method, params)
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
		vim.notify("Failed to move file: " .. err, vim.log.levels.ERROR)
		return
	end

	notify_clients("workspace/didRenameFiles", params)

	local current_buf = vim.api.nvim_get_current_buf()
	local current_buf_name = vim.api.nvim_buf_get_name(current_buf)

	if current_buf_name == source then
		vim.cmd.file(target)
		vim.cmd.e()
	end

	print("Moved: " .. vim.fn.fnamemodify(source, ":t") .. " -> " .. vim.fn.fnamemodify(target, ":t"))
end

function M.delete_file(path)
	local uri = vim.uri_from_fname(path)
	local params = { files = { { uri = uri } } }

	request_changes("workspace/willDeleteFiles", params, "Deleting File")

	local success, err = os.remove(path)
	if not success then
		vim.notify("Failed to delete file: " .. err, vim.log.levels.ERROR)
		return
	end

	notify_clients("workspace/didDeleteFiles", params)

	local current_buf = vim.api.nvim_get_current_buf()
	if vim.api.nvim_buf_get_name(current_buf) == path then
		vim.cmd("bdelete!")
	end

	print("Deleted: " .. vim.fn.fnamemodify(path, ":t"))
end

function M.rename_current_buffer()
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		return print("Buffer has no name")
	end

	vim.ui.input({
		prompt = "New path: ",
		completion = "file",
		default = current_file,
	}, function(input)
		print("Input " .. input)
		if input and input ~= "" and input ~= current_file then
			M.move_file(current_file, input)
		end
	end)
end

function M.delete_current_buffer()
	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file == "" then
		return print("Buffer has no name")
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
