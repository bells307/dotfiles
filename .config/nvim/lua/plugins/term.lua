return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
    },
    lazy = false,
    config = function(opts)
      require("toggleterm").setup(opts)

      local map = vim.keymap.set
      map("t", "<esc>", [[<C-\><C-n>]], { silent = true })
    end,
  },
}
