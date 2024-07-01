-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("vimrc_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Do not auto comment new line",
  group = augroup("disable_auto_comment"),
  command = [[set formatoptions-=cro]],
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Close some filetypes with <q>",
  pattern = {
    "PlenaryTestPopup",
    "TelescopePrompt",
    "chatgpt",
    "checkhealth",
    "dap-repl",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "nnn",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close!<cr>", { buffer = event.buf, silent = true })
  end,
  group = augroup("close_with_q"),
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at same location where it was opened last time",
  callback = function()
    vim.cmd([[silent! normal! g`"]])
  end,
  group = augroup("last_loc"),
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Go to last location when opening a buffer",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  group = augroup("last_loc"),
})
