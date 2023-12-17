local dap_ui = require('dapui')

dap_ui.setup({
    icons = { expanded = '▾', collapsed = '▸' },
    mappings = {
        -- use custom bindings
        expand = { "<cr>", "<2-leftmouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
    },
    sidebar = {
        open_on_start = true,
        elements = {
            -- provide as needed
            {
                id = "scopes",
                size = 0.25
            },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 00.25 },
        },
    },
    tray = {
        open_on_start = true,
        elements = {
            -- provide as needed
            -- { id = "repl" },
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        mappings = {
            close = { "q", "<esc>" },
        },
    },
    windows = { indent = 1 },
})

vim.api.nvim_set_keymap('n', '<f5>', ':lua require"dap".continue()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<f10>', ':lua require"dap".step_over()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<f11>', ':lua require"dap".step_into()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<f12>', ':lua require"dap".step_out()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<cr>', { noremap = true, silent = true })
