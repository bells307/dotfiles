-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- disable cursor flicker in alacritty + zellij
vim.opt.termsync = false

vim.o.guifont = "Fira Code:h14"

-- Enable wrap
vim.o.wrap = true

-- Autom. read file when changed outside of Vim
vim.o.autoread = true

-- Autom. save file before some action
vim.o.autowrite = true
