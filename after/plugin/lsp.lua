local FORMATTING_ENABLED = true
local DIAGNOSTICS_ENABLED = true

local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")
-- local jdtls_test = require("jdtls.tests")
local telescope = require("telescope.builtin")

lsp.preset("recommended")

lsp.extend_lspconfig()

require("mason").setup({
	log_level = vim.log.levels.DEBUG,
})

require("mason-nvim-dap").setup({
	ensure_installed = { "delve" },
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"rust_analyzer",
		"ltex",
	},
	handlers = {
		lsp.default_setup,
	},
})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),

		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

local lua_opts = lsp.nvim_lua_ls()
lspconfig.lua_ls.setup(lua_opts)

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

    vim.lsp.inlay_hint.enable(bufnr)

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gi", function()
		vim.lsp.buf.implementation()
	end, opts)

	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vsd", function()
		require("trouble").toggle("document_diagnostics")
	end, opts)
	vim.keymap.set("n", "<leader>vwd", function()
		require("trouble").toggle("workspace_diagnostics")
	end)

	vim.keymap.set("n", "<leader>vgr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)

	vim.keymap.set("n", "<leader>f", function()
		if FORMATTING_ENABLED then
			vim.lsp.buf.format()
		end
	end, opts)

	vim.keymap.set({ "n", "v" }, "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set({ "i", "n" }, "<C-p>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.keymap.set("n", "<leader>gr", telescope.lsp_references, opts)
	vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols, opts)
	vim.keymap.set("n", "<leader>ws", function()
		telescope.lsp_workspace_symbols({
			query = vim.fn.input("Query or empty > "),
		})
	end, opts)
	vim.keymap.set("n", "<leader>dws", function()
		telescope.lsp_dynamic_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>vtd", telescope.diagnostics, opts)
	-- vim.keymap.set("n", "<leader>jct", function()
	--     jdtls_test.generate()
	-- end)
	-- vim.keymap.set("n", "<leader>jgt", function()
	--     jdtls_test.goto_subjects()
	-- end)
	-- vim.keymap.set("n", "<leader>jtn", function()
	--     jdtls_test.test_nearest_method()
	-- end)
end

lsp.on_attach(function(client, bufnr)
	on_attach(client, bufnr)
end)

lspconfig.phpactor.setup({
	on_attach = on_attach,
})

lspconfig.kotlin_language_server.setup({
	on_attach = on_attach,
})

lspconfig.gopls.setup({
	on_attach = on_attach,
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = DIAGNOSTICS_ENABLED,
})

local opts = {
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	server = {
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}

require("rust-tools").setup(opts)

function SetFormattingEnabled(enable)
	FORMATTING_ENABLED = enable
end

function SetDiagnosticsEnabled(enable)
	DIAGNOSTICS_ENABLED = enable
	vim.diagnostic.config({
		virtual_text = DIAGNOSTICS_ENABLED,
	})
end
