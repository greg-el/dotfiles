vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	require("mason").setup()

	use({ "neovim/nvim-lspconfig", opts = { inlay_hints = { enabled = true } } })
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
	use("MunifTanjim/nui.nvim")

	use({
		"nvim-neo-tree/neo-tree.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		branch = "v2.x",
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
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
		tag = "0.1.5",
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

	-- Commentary
	-- https://github.com/tpope/vim-commentary
	use("tpope/vim-commentary")

	-- Github
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
	})

	-- Auto line nums
	use("myusuf3/numbers.vim")

	-- Multi Cursor
	use("terryma/vim-multiple-cursors")

	-- Themes
	use("morhetz/gruvbox")
	use("Shatur/neovim-ayu")
	use("navarasu/onedark.nvim")
	use("rebelot/kanagawa.nvim")
	use("RRethy/nvim-base16")
end)
