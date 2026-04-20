vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Exit insert mode
map("i", "jj", "<Esc>")
map("i", "jk", "<Esc>")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Stay in indent mode when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Keep cursor centered when scrolling / searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Paste without overwriting register
map("v", "p", '"_dP')

-- Delete without overwriting register
map({ "n", "v" }, "<leader>d", '"_d')

-- Copy relative filepath to clipboard
map("n", "<leader>y", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative filepath" })

-- Save
map("n", "<leader>w", "<cmd>w<CR>")

-- Quit
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>Q", "<cmd>qa!<CR>")

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>")
map("n", "<S-l>", "<cmd>bnext<CR>")
map("n", "<leader>bd", "<cmd>bdelete<CR>")

-- Diagnostic navigation
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

map("n", "<leader>tw", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle word wrap" })

map("n", "<leader>tb", function()
	vim.o.background = vim.o.background == "dark" and "light" or "dark"
end, { desc = "Toggle background light/dark" })

map("n", "<leader>ts", function()
	vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle whitespace visualization" })

-- Toggle diagnostics visibility
map("n", "<leader>td", function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable(true)
	end
end, { desc = "Toggle diagnostics" })

-- Toggle diagnostic underlines
map("n", "<leader>tu", function()
	local cfg = vim.diagnostic.config()
	if cfg then
		vim.diagnostic.config({ underline = not cfg.underline })
	end
end, { desc = "Toggle diagnostic underlines" })

-- Toggle Russian/English keyboard layout
map({ "n", "i" }, "<S-Tab>", function()
	vim.opt.iminsert = vim.opt.iminsert:get() == 0 and 1 or 0
end, { desc = "Toggle Russian/English layout" })
