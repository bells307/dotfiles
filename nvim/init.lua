require("core.lazy")
require("core.options")
require("core.keymaps")
require("core.russian")
require("core.lsp")
require("core.statusline")

local theme_file = io.open(vim.fn.expand("~/.config/current-theme"), "r")
local current_theme = theme_file and theme_file:read("*l") or "dark"
if theme_file then theme_file:close() end

vim.cmd.colorscheme(current_theme == "light" and "github_light" or "kanagawa-wave")
