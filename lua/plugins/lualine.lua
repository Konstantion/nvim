return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        local custom_gruvbox = require("lualine.themes.gruvbox")
        local normal_mode_color = custom_gruvbox.normal.a.bg

        custom_gruvbox.normal.a.bg = normal_mode_color
        custom_gruvbox.insert.a.bg = normal_mode_color
        custom_gruvbox.visual.a.bg = normal_mode_color
        custom_gruvbox.replace.a.bg = normal_mode_color
        custom_gruvbox.command.a.bg = normal_mode_color
        custom_gruvbox.inactive.a.bg = normal_mode_color

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = custom_gruvbox, -- Apply the custom theme directly
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "branch",
                        fmt = function(str)
                            return str:sub(1, 10)
                        end,
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        sections = { "error", "warn", "info", "hint" },
                        symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                        colored = true,
                        update_in_insert = false,
                        always_visible = false,
                    },
                },
                lualine_c = { "filename" },
                lualine_x = {
                    { "encoding" },
                    { "filetype" },
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
