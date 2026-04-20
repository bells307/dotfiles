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
map("n", "<leader>yy", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative filepath" })

-- Copy relative filepath with current line
map("n", "<leader>yl", function()
	vim.fn.setreg("+", vim.fn.expand("%") .. ":" .. vim.fn.line("."))
end, { desc = "Copy relative filepath with line" })

-- Copy relative filepath with selected line range
map("v", "<leader>y", function()
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end
	local ref = vim.fn.expand("%") .. ":" .. start_line
	if start_line ~= end_line then
		ref = ref .. "-" .. end_line
	end
	vim.fn.setreg("+", ref)
	vim.cmd("normal! \27")
end, { desc = "Copy relative filepath with line range" })

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
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end)
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end)
map("n", "[e", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end)
map("n", "]e", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end)
map("n", "[w", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
end)
map("n", "]w", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
end)

local state = require("core.state")

vim.wo.wrap = state.get("wrap", false)
vim.opt.list = state.get("list", false)
if not state.get("diagnostics", true) then
	vim.diagnostic.enable(false)
end

map("n", "<leader>tw", function()
	vim.wo.wrap = not vim.wo.wrap
	state.set("wrap", vim.wo.wrap)
end, { desc = "Toggle word wrap" })

map("n", "<leader>ts", function()
	vim.opt.list = not vim.o.list
	state.set("list", vim.o.list)
end, { desc = "Toggle whitespace visualization" })

-- Toggle diagnostics visibility
map("n", "<leader>td", function()
	local enabled = vim.diagnostic.is_enabled()
	vim.diagnostic.enable(not enabled)
	state.set("diagnostics", not enabled)
end, { desc = "Toggle diagnostics" })

-- Toggle diagnostic underlines
map("n", "<leader>tu", function()
	local cfg = vim.diagnostic.config()
	if cfg then
		vim.diagnostic.config({ underline = not cfg.underline })
		state.set("diagnostic_underline", not cfg.underline)
	end
end, { desc = "Toggle diagnostic underlines" })

-- Toggle Russian/English keyboard layout
map({ "n", "i" }, "<S-Tab>", function()
	vim.opt.iminsert = vim.o.iminsert == 0 and 1 or 0
end, { desc = "Toggle Russian/English layout" })
