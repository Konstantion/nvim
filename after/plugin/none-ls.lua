local null_ls = require("null-ls")

local home = os.getenv("HOME")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.codespell,
        null_ls.builtins.formatting.phpcsfixer,
        -- null_ls.builtins.formatting.google_java_format,
        --
        -- null_ls.builtins.diagnostics.checkstyle.with({
        --     extra_args = { '-c' , home .. "/work/checkstyle/checkstyle.xml" },
        -- }),
        null_ls.builtins.diagnostics.chktex,
    },
})
