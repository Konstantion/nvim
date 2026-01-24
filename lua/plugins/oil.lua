return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = {
			"icon",
		},
        view_options = {
			show_hidden = true,
		},
        lsp_file_methods = {
            enabled = true,
            autosave_changes = true,
        },
	},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	-- Using the 'keys' method I recommended in the previous turn
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		{ "<leader>pv", "<CMD>Oil<CR>", desc = "Open parent directory" },
		{
			"gt",
			function()
				local oil = require("oil")
				local config = require("oil.config")
				if #config.columns == 1 then
					oil.set_columns({ "icon", "permissions", "size", "mtime" })
				else
					oil.set_columns({ "icon" })
				end
			end,
			desc = "Toggle file detail view",
		},
	},
}
