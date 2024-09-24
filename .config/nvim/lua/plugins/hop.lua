return {
  {
    "phaazon/hop.nvim",
    event = "BufReadPre",
    keys = {
      { "<tab>", "<cmd>HopWord<cr>", desc = "Hop Word" },
      { "<leader>hw", "<cmd>HopWord<cr>", desc = "Hop Word" },
      { "<leader>ha", "<cmd>HopAnywhere<cr>", desc = "Hop Anywhere" },
    },
    opts = {},
  },
}
