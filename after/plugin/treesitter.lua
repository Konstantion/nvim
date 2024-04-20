local function disable(lang)
	local bufferName = vim.api.nvim_buf_get_name(0)
	if string.find(bufferName, ".mod") then
		return true
	end
end

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "java", "c", "lua", "vim", "vimdoc" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		enable = true,
		disable = { "groovy", "txt", "mod" },

		additional_vim_regex_highlighting = false,
	},
})
