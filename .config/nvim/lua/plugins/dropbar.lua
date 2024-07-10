return {
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    event = { "BufReadPre" },
    keys = {
      { "<leader>td", ":lua require('dropbar.api').pick()<CR>", desc = "Toggle Dropbar" },
    },
  },
}
