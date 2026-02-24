return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	keys = {
		{
			"<leader>pf",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find Files",
		},
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Find Buffers",
		},
		{
			"<leader>gf",
			function()
				require("telescope.builtin").git_files()
			end,
			desc = "Git Files",
		},
		{
			"<leader>pc",
			function()
				require("telescope.builtin").commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>pg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Live Grep",
		},
		{
			"<leader>ps",
			function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
			end,
			desc = "Grep String",
		},
	},

	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				path_display = function(_, path)
					local tail = require("telescope.utils").path_tail(path)
					return string.format("%s — %s", tail, path), { { { 1, #tail }, "Constant" } }
				end,
				history = {
					path = vim.fn.stdpath("data") .. "/telescope_history",
					limit = 100,
				},
				mappings = {
					i = {
						["<C-Up>"] = require("telescope.actions").cycle_history_prev,
						["<C-Down>"] = require("telescope.actions").cycle_history_next,
					},
				},
			},
			extensions = {
				fzf = {},
			},
		})

		telescope.load_extension("fzf")
	end,
}
