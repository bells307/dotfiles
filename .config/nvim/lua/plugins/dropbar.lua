return {
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    event = { "BufReadPre" },
    keys = {
      { "<leader>D", ":lua require('dropbar.api').pick()<CR>", desc = "Dropbar pick" },
    },
  },
}
