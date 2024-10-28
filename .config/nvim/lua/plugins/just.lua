return {
  "al1-ce/just.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- async jobs
    "nvim-telescope/telescope.nvim", -- task picker
    "rcarriga/nvim-notify", -- general notifications (optional)
    "j-hui/fidget.nvim", -- task progress
    "al1-ce/jsfunc.nvim", -- extension library
  },
  keys = {
    { "<leader>j", "<cmd>JustSelect<cr>", desc = "Select task in Justfile" },
  },
  config = true,
}
