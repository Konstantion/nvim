return {
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"github/copilot.vim",
		lazy = false, -- Load immediately so it can attach
		config = function()
			-- Optional: Map <C-J> to accept suggestion if you prefer that over <Tab>
			-- vim.g.copilot_no_tab_map = true
			-- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
			--     expr = true,
			--     replace_keycodes = false
			-- })
		end,
	},

	{
		"laytan/cloak.nvim",
		ft = { "sh", "env" }, -- Only load for shell/env files
		opts = {
			enabled = true,
			cloak_character = "*",
			highlight_group = "Comment",
			patterns = {
				{
					file_pattern = ".env*",
					cloak_pattern = "=.+",
				},
			},
		},
	},

	{
		"eandrju/cellular-automaton.nvim",
	},

	{
		"airblade/vim-rooter",
		init = function()
			-- Configuration goes in 'init' because it is a Vimscript plugin
			vim.g.rooter_patterns = { ".git", "Makefile", "*.sln", "build/env.sh" }
			vim.g.rooter_silent_chdir = 1
		end,
	},

	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			-- We can set global variables here before the plugin loads
			vim.g.vm_theme = "ocean"
			-- Keymaps are usually fine by default (Ctrl-N to select word),
			-- but you can customize them here if needed.
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true, -- Auto-calls setup()
		-- Optional: integration with cmp
		dependencies = { "hrsh7th/nvim-cmp" },
		init = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- Load immediately
		priority = 1000, -- Load before everything else
		config = function()
			require("github-theme").setup({
				options = {
					-- Compile the theme for faster startup
					compile_path = vim.fn.stdpath("cache") .. "/github-theme",
					compile_file_suffix = "_compiled",
					hide_end_of_buffer = true, -- Hide the '~' characters after the end of buffers
					transparent = false, -- Set to true if you want a transparent background
				},
			})

			-- Set the default colorscheme to Dark High Contrast
			vim.cmd("colorscheme github_dark_high_contrast")
		end,
	},

	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			columns = {
				"icon",
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
					-- local config = oil.get_config()
                    local config = require("oil.config")
					if #config.columns == 1 then
						-- If currently simple, switch to detailed

						oil.set_columns({ "icon", "permissions", "size", "mtime" })
					else
						-- If currently detailed, switch back to simple
						oil.set_columns({ "icon" })
                    end
				end,
				desc = "Toggle file detail view",
			},
		},
	},
}
