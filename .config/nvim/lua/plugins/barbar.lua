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
    opts = {},
    config = function(_, opts)
      require("barbar").setup(opts)
      local map = vim.api.nvim_set_keymap

      -- Move to previous/next
      map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
      map("n", "<A-.>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
      -- Re-order to previous/next
      map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { desc = "Buffer move previous" })
      map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { desc = "Buffer move next" })
      -- Goto buffer in position...
      map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { desc = "Go to Buffer 1" })
      map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { desc = "Go to Buffer 2" })
      map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { desc = "Go to Buffer 3" })
      map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { desc = "Go to Buffer 4" })
      map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { desc = "Go to Buffer 5" })
      map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { desc = "Go to Buffer 6" })
      map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { desc = "Go to Buffer 7" })
      map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { desc = "Go to Buffer 8" })
      map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { desc = "Go to Buffer 9" })
      map("n", "<A-0>", "<Cmd>BufferLast<CR>", { desc = "Go to last buffer" })
      -- Goto pinned/unpinned buffer
      --                 :BufferGotoPinned
      --                 :BufferGotoUnpinned
      -- Close buffer
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      map("n", "<C-p>", "<Cmd>BufferPick<CR>", { desc = "Pick buffer" })
      -- Sort automatically by...
      map("n", "<leader>bd", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })
      map("n", "<leader>bc", "<Cmd>BufferCloseAllButCurrent<CR>", { desc = "Close all buffers but current" })
      map("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", { desc = "Order buffers by number" })
      map("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = "Pin buffer" })
      map("n", "<leader>bn", "<Cmd>BufferOrderByName<CR>", { desc = "Order buffers by name" })
      map("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", { desc = "Order buffers by language" })
      map("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", { desc = "Order buffers by window number" })
    end,
    version = "^1.0.0",
  },
}
