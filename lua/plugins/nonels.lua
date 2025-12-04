return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "jay-babu/mason-null-ls.nvim", -- Helper to install formatters via Mason
    },
    config = function()
        local null_ls = require("null-ls")
        local mason_null_ls = require("mason-null-ls")

        mason_null_ls.setup({
            ensure_installed = {
                "stylua",             -- Lua formatter
                "google_java_format", -- Java formatter
            },
            automatic_installation = true,
        })

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.google_java_format,
            },
        })
    end,
}
