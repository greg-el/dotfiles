--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
	autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local TAB_WIDTH = 4
vim.opt.tabstop = TAB_WIDTH
vim.opt.softtabstop = TAB_WIDTH
vim.opt.shiftwidth = TAB_WIDTH

--------------------------------------------------------
-- Themes
--------------------------------------------------------

vim.cmd.colorscheme("kanagawa")

-- Remove tilde ~ on empty lines
vim.opt.fillchars:append({ eob = " " })

--------------------------------------------------------
-- Tabs (Barbar)
--------------------------------------------------------
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Mac uses Alt(Option) to insert characters, so binds like `<A-,>` won't work:
-- We can set the binds to the character inserted by MacOS

local os = io.popen("uname -s", "r"):read("*l")

if os == "Darwin" then
	-- Move prev/next
	map("n", "≤", "<Cmd>BufferPrevious<CR>", opts)
	map("n", "≥", "<Cmd>BufferNext<CR>", opts)

	-- Close
	map("n", "…", "<Cmd>BufferClose<CR>", opts)
end

-- Move prev/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

-- Close
map("n", "<A-;>", "<Cmd>BufferClose<CR>", opts)

-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
