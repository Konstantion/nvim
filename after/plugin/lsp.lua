local lsp = require("lsp-zero")

lsp.preset("recommended")

-- Extend lspconfig with lsp-zero to avoid errors
lsp.extend_lspconfig()

require("mason").setup {
    log_level = vim.log.levels.DEBUG
}

require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'rust_analyzer',
        'ltex',
        -- Add lua_ls if you're working with Lua
    },
    handlers = {
        lsp.default_setup,
    },
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- The following lines are for integrating with LuaSnip, if you use it
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    })
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local lua_opts = lsp.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)


lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)

    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

    vim.keymap.set("n", "<leader>vgr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)

    vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("i", "<C-p>", function() vim.lsp.buf.signature_help() end, opts)
    -- I like this telescope bindings
    vim.keymap.set("n", "<leader>gr", require('telescope.builtin').lsp_references, opts)
    vim.keymap.set("n", "<leader>ds", require('telescope.builtin').lsp_document_symbols, opts)
end)

require('lspconfig').phpactor.setup {
    on_attach = lsp.on_attach,
}

local null_ls = require("null-ls")

null_ls.setup({
    on_attach = lsp.on_attach,
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
