return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                -- A list of parser names, or "all" (not recommended)
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "query", -- Required for Neovim/Lazy to work well
                    "java", "rust",                       -- Your specific languages
                    "javascript", "html", "typescript"    -- Common web standards
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                indent = { enable = true },
            })
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            enable = true,            -- Enable this plugin
            max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0,    -- Minimum editor window height to enable context.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded.
            mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
            separator = nil,          -- Separator between context and content. e.g. "-"
            zindex = 20,              -- The Z-index of the context window
        }
    }
}
