-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Move current line / block with Alt-j/k ala vscode.
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move down", noremap = true, silent = true })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move up", noremap = true, silent = true })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down", noremap = true, silent = true })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up", noremap = true, silent = true })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down", noremap = true, silent = true })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up", noremap = true, silent = true })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Better page up/down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
