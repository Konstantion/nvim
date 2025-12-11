return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" }, -- Text from current buffer
                    { name = "path" },   -- File system paths
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(),

                    ["<C-n>"] = cmp.mapping.select_next_item(),

                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                    ["<C-Space>"] = cmp.mapping.complete(),

                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),

                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                -- Enable Inlay Hints (Modern Neovim 0.10+)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end

                -- Keybindings
                -- --------------------------------------------------------
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)

                -- Diagnostics
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)

                vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)

                vim.keymap.set("n", "<leader>vsd", function() require("trouble").toggle("diagnostics") end, opts)

                -- Actions
                vim.keymap.set("n", "<leader>vgr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts)

                -- Formatting (No toggle logic, just format)
                vim.keymap.set({ "n", "v" }, "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)

                -- Information
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set({ "i", "n" }, "<C-p>", function() vim.lsp.buf.signature_help() end, opts)

                -- Telescope Integrations
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>gr", builtin.lsp_references, opts)
                vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, opts)
                vim.keymap.set("n", "<leader>ws", function()
                    builtin.lsp_workspace_symbols({ query = vim.fn.input("Query > ") })
                end, opts)
                vim.keymap.set("n", "<leader>dws", builtin.lsp_dynamic_workspace_symbols, opts)
                vim.keymap.set("n", "<leader>vtd", builtin.diagnostics, opts)
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "ts_ls", "lua_ls" }, -- Added lua_ls per your previous request
                handlers = {
                    -- Default Handler (applied to everything else)
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })

            -- Diagnostic Config (Virtual Text)
            vim.diagnostic.config({
                virtual_text = true,
            })
        end,
    },
}
