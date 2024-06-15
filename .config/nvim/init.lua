-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.neovide then
  vim.g.neovide_transparency = 0.6
  vim.g.neovide_window_blurred = true
end
