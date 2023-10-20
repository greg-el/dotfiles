require("plugins")
local map = require("helpers").map

-- Space to the left of the line numbers for git gutter
vim.wo.signcolumn = "yes:1"
vim.wo.number = true

-- Sets leader to ,
vim.g.mapleader = ","

-- LSP Shortcuts

vim.api.nvim_set_keymap("n", "<Leader>f", [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], { noremap = true, silent = true })

-- LSP Setups
require("lspconfig").lua_ls.setup({
	on_attach = function()
		vim.cmd([[autocmd BufWritePre <buffer> lua require'stylua-nvim'.format_file()]])
		vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
	end,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "use" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- TypeScript

require("lspconfig").tsserver.setup({
	on_attach = function()
		vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
	end,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
})

-- Lualine
require("lualine").setup({
	options = {
		theme = "kanagawa",
		section_separators = "",
		component_separators = "",
	},
})

-- Rust Tools
local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

			-- Format on save
			vim.cmd([[autocmd BufWritePre *.rs lua vim.lsp.buf.format({ async = false })]])
		end,
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])

-- Completion Plugin Setup
--
local cmp = require("cmp")
cmp.setup({
	-- Enable LSP snippets
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Add tab support
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	-- Installed sources:
	sources = {
		{ name = "path" },                                 -- file paths
		{ name = "nvim_lsp",               keyword_length = 3 }, -- from language server
		{ name = "nvim_lsp_signature_help" },              -- display function signatures with current parameter emphasized
		{ name = "nvim_lua",               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "buffer",                 keyword_length = 2 }, -- source current buffer
		{ name = "vsnip",                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		{ name = "calc" },                                 -- source for math calculation
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				vsnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
})

-- Telescope

map("n", "<Leader>s", ":Telescope live_grep<CR>", {})
map("n", "<Leader>g", ":Telescope git_files<CR>", {})
map("n", "<Leader>p", ":Telescope find_files<CR>", {})
map("n", "<Leader>d", ":Telescope diagnostics<CR>", {})

require("octo").setup()

require("neo-tree-setup")
require("opts")
