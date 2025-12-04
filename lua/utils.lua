local M = {}

M.show_absolute_path = function()
	local filepath = vim.api.nvim_buf_get_name(0)

	if filepath == "" then
		print("Empty buffer (no file)")
	else
		print(filepath)
	end
end

M.copy_absolute_path = function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath == "" then
		print("Empty buffer (no file)")
	else
		vim.fn.setreg("+", filepath)

		vim.notify("Copied to clipboard: " .. filepath, vim.log.levels.INFO)
	end
end

_G.utils = M

return M
