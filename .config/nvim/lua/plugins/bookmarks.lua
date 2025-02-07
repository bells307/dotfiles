return {
  "tomasky/bookmarks.nvim",
  -- after = "telescope.nvim",
  event = "VimEnter",
  config = function()
    require("bookmarks").setup({
      -- sign_priority = 8,  --set bookmark sign priority to cover other sign
      save_file = vim.fn.expand("$HOME/.bookmarks"), -- bookmarks save file path
      keywords = {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
      },
      on_attach = function(_)
        local bm = require("bookmarks")
        local map = vim.keymap.set
        map("n", "<leader>mm", bm.bookmark_toggle, { desc = "Add or remove bookmark at current line" })
        map("n", "<leader>mi", bm.bookmark_ann, { desc = "Add or edit mark annotation at current line" })
        map("n", "<leader>mc", bm.bookmark_clean, { desc = "Clean all marks in local buffer" })
        map("n", "<leader>mn", bm.bookmark_next, { desc = "Jump to next mark in local buffer" })
        map("n", "<leader>mp", bm.bookmark_prev, { desc = "Jump to previous mark in local buffer" })
        map("n", "<leader>ml", bm.bookmark_list, { desc = "Show marked file list in quickfix window" })
        map("n", "<leader>mx", bm.bookmark_clear_all, { desc = "Removes all bookmarks" })
      end,
    })

    -- require("telescope").load_extension("bookmarks")
    -- vim.keymap.set("n", "<leader>fb", function()
    --   require("telescope").extensions.bookmarks.list()
    -- end, { desc = "Find Bookmarks" })
  end,
}
