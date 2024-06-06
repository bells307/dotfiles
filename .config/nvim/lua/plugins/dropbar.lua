return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>D", ":lua require('dropbar.api').pick()<CR>", { desc = "Dropbar pick" })
    end,
  },
}
