local utils = require("utils")

local augroup = vim.api.nvim_create_augroup
local buf_group = augroup("PrePostBuf", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = buf_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_augroup("OilCustomMaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "OilCustomMaps",
	pattern = "oil",
	callback = function()
		vim.keymap.set("n", "K", function()
			local oil = require("oil")
			local entry = oil.get_cursor_entry()
			local dir = oil.get_current_dir()

			if not entry or not dir then
				return
			end

			local full_path = dir .. entry.name

			local content = {
				full_path,
			}

			utils.open_smart_float(content)
		end, { buffer = true, silent = true, desc = "Show file metadata" })
	end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client ~= nil and vim.lsp.client.supports_method(client, "textDocument/codeLens") then
			vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
				buffer = args.buf,
				callback = function()
					vim.lsp.codelens.refresh({ bufnr = args.buf })
				end,
			})
			vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { buffer = args.buf, desc = "LSP Code Lens" })
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client ~= nil and vim.lsp.client.supports_method(client, "textDocument/documentHighlight") then
			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = args.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd("CursorMoved", {
				buffer = args.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})
