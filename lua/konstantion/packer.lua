print("Packer")

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-treesitter/nvim-treesitter"})
	use("nvim-treesitter/playground")
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use("nvim-treesitter/nvim-treesitter-context")
	use("theprimeagen/refactoring.nvim")

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			{
				"neovim/nvim-lspconfig",
				opts = {
					inlay_hints = {
						enabled = true,
					},
				},
			},

			{ "williamboman/mason.nvim" },

			{ "williamboman/mason-lspconfig.nvim" },
			{ "jay-babu/mason-nvim-dap.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	use("airblade/vim-rooter")
	use("folke/zen-mode.nvim")
	use("github/copilot.vim")
	use("eandrju/cellular-automaton.nvim")
	use("laytan/cloak.nvim")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")

	use("tpope/vim-surround")
	use("nvimtools/none-ls.nvim")
	use("mfussenegger/nvim-jdtls")

	use("rebelot/kanagawa.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({ "rose-pine/neovim", as = "rose-pine" })
	use("tpope/vim-dadbod")
	use("lvimuser/lsp-inlayhints.nvim")
	use("ray-x/go.nvim")
	use("Weissle/persistent-breakpoints.nvim")
	use("terryma/vim-multiple-cursors")
	use("nvim-tree/nvim-web-devicons")
	use({ "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } })
	use("editorconfig/editorconfig-vim")
	use("simrat39/rust-tools.nvim")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = false
			vim.o.timeoutlen = 999999
		end,
	})
	use({ "nvim-neotest/nvim-nio" })
	use({
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup()
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})
end)
