vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	require("mason").setup()

	use("neovim/nvim-lspconfig")
	use("simrat39/rust-tools.nvim")

	-- Completion framework:
	use("hrsh7th/nvim-cmp")

	-- LSP completion source:
	use("hrsh7th/cmp-nvim-lsp")

	-- Useful completion sources:
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/vim-vsnip")

	-- LSP format
	use("lukas-reineke/lsp-format.nvim")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")

	-- File browser
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- Tabs
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- Lua
	use({ "ckipp01/stylua-nvim", run = "cargo install stylua" })

	-- Fuzzy search
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Svelte
	use({
		"evanleck/vim-svelte",
		requires = {
			"pangloss/vim-javascript",
			"othree/html5.vim",
		},
	})

	-- Github
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
	})

	-- Themes
	use("morhetz/gruvbox")
	use("Shatur/neovim-ayu")
	use("navarasu/onedark.nvim")
	use({ "rebelot/kanagawa.nvim", commit = "fc2e308" })
	use("RRethy/nvim-base16")
end)
