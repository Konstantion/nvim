local dap_ui = require("dapui")

dap_ui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use custom bindings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
	},
	sidebar = {
		open_on_start = true,
		elements = {
			{
				id = "scopes",
				size = 0.25,
			},
			{ id = "breakpoints", size = 0.25 },
			{ id = "stacks", size = 0.25 },
			{ id = "watches", size = 00.25 },
		},
	},
	tray = {
		open_on_start = true,
		elements = {
			-- Provide as needed
			-- { id = "repl" },
		},
	},
	floating = {
		max_height = nil,
		max_width = nil,
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
})

local dap = require("dap")

vim.keymap.set("n", "<leader>dcc", dap.continue, { silent = true })
-- vim.keymap.set('n', '<leader>dso', dap.step_over, { silent = true })
-- vim.keymap.set('n', '<leader>dsi', dap.step_into, { silent = true })
-- vim.keymap.set('n', '<leader>dsu', dap.step_out, { silent = true })
vim.keymap.set("n", "<leader>b", ":PBToggleBreakpoint<CR>", { silent = true, noremap = true })
-- vim.keymap.set('n', '<leader>dst', ':DapStop<CR>', { silent = true })

require("persistent-breakpoints").setup({
	load_breakpoints_event = { "BufRead" },
})
