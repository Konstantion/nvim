local FORMATTING_ENABLED = true
local DIAGNOSTICS_ENABLED = true

local lsp = require("lsp-zero")

local function get_install_path_for(package)
	return require("mason-registry").get_package(package):get_install_path()
end

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
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}),
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
require("lspconfig").lua_ls.setup(lua_opts)

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<leader>ih", vim.lsp.inlay_hint.get, opts)
	vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
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
	vim.keymap.set("n", "<leader>vfd", function()
		require("trouble").toggle("document_diagnostics")
	end, opts)
	vim.keymap.set("n", "<leader>wd", function()
		require("trouble").toggle("workspace_diagnostics")
	end)

	vim.keymap.set("n", "<leader>vgr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)

	vim.keymap.set("n", "<leader>f", function()
		-- print("Formatting command triggered. Current setting: " .. tostring(FORMATTING_ENABLED))
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
	vim.keymap.set("i", "<C-p>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, opts)
	vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
	vim.keymap.set("n", "<leader>ws", function()
		require("telescope.builtin").lsp_workspace_symbols({
			query = vim.fn.input("Query or empty > "),
		})
	end, opts)
	vim.keymap.set("n", "<leader>dws", function()
		require("telescope.builtin").lsp_dynamic_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, opts)
	vim.keymap.set("n", "<leader>ct", function()
		local plugin = require("jdtls.tests")
		plugin.generate()
	end)
	vim.keymap.set("n", "<leader>gt", function()
		local plugin = require("jdtls.tests")
		plugin.goto_subjects()
	end)
	vim.keymap.set("n", "<leader>vtn", function()
		require("jdtls").test_nearest_method()
	end)
	vim.keymap.set("n", "<leader>gD", require("telescope.builtin").lsp_type_definitions, opts)
	vim.keymap.set("n", "<leader>vic", vim.lsp.buf.incoming_calls, opts)
	vim.keymap.set("n", "<leader>voc", vim.lsp.buf.outgoing_calls, opts)
end)

require("lspconfig").phpactor.setup({
	on_attach = lsp.on_attach,
})

require("lsp-inlayhints").on_attach = lsp.on_attach

lsp.setup()

vim.diagnostic.config({
	virtual_text = DIAGNOSTICS_ENABLED,
})

function SetFormattingEnabled(enable)
	FORMATTING_ENABLED = enable
end

function SetDiagnosticsEnabled(enable)
	DIAGNOSTICS_ENABLED = enable
	vim.diagnostic.config({
		virtual_text = DIAGNOSTICS_ENABLED,
	})
end
