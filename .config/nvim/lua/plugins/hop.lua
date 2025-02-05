return {
  {
    "phaazon/hop.nvim",
    event = "BufReadPre",
    keys = {
      { "gw", "<cmd>HopWord<cr>", desc = "Hop Word" },
    },
    opts = {},
  },
}
