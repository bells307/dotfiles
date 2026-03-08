local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Cursor
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.showmode = false
opt.wrap = false

opt.conceallevel = 0
opt.pumheight = 10
opt.cmdheight = 1

-- Whitespace visualization
opt.list = false
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Files
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undolevels = 10000

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menuone,noselect,popup"
opt.shortmess:append("c") -- suppress "Pattern not found" from auto-completion

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Folds (using treesitter when available)
opt.foldmethod = "indent"
opt.foldlevel = 99

-- Keyboard layout
opt.keymap = "russian-jcuken"
opt.iminsert = 0
opt.imsearch = 0
opt.langmap =
	"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- Netrw
vim.g.netrw_banner = 0 -- hide banner
vim.g.netrw_liststyle = 3 -- tree view by default
vim.g.netrw_winsize = 25 -- width when split (%)
vim.g.netrw_browse_split = 4 -- open files in previous window
