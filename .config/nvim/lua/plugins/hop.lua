return {
  {
    "phaazon/hop.nvim",
    event = "BufReadPre",
    keys = {
      { "<cr>", "<cmd>HopWord<cr>", desc = "Hop Word" },
      { "<leader>hw", "<cmd>HopWord<cr>", desc = "Hop Word" },
      { "<leader>ha", "<cmd>HopAnywhere<cr>", desc = "Hop Anywhere" },
    },
    opts = {},
  },
}
