local dap = require('dap')
local dap_ui = require('dapui')

-- The path might differ based on where Mason installs the debug adapters
local debug_path = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'

dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { debug_path },
}

dap.configurations.javascript = {
    {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
    },
}

dap_ui.setup({
    icons = { expanded = '▾', collapsed = '▸' },
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
            -- Provide as needed
            -- { id = "scopes",
            -- size = 0.25 },
            -- { id = "breakpoints", size = 0.25 },
            -- { id = "stacks", size = 0.25 },
            -- { id = "watches", size = 00.25 },
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

vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
