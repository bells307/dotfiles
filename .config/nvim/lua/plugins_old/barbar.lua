return {
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    lazy = false,
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    keys = {
      { "<leader>bf", "<Cmd>BufferPick<CR>", desc = "Buffer Pick" },
      { "<leader>bp", "<Cmd>BufferPin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferCloseAllButPinned<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferCloseBuffersRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferCloseBuffersLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferPrevious<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferMovePrevious<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {},
    version = "^1.0.0",
  },
}
