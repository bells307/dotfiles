return {
  {
    "numToStr/FTerm.nvim",
    opts = {
      border = "double",
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    },
    config = function(opts)
      require("FTerm").setup(opts)

      vim.keymap.set("n", "<C-\\>", '<CMD>lua require("FTerm").toggle()<CR>')
      vim.keymap.set("n", "<leader>tt", '<CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle terminal" })
      vim.keymap.set("t", "<C-\\>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
    end,
  },
}
