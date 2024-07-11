return {
  {
    "numToStr/Comment.nvim",
    config = function(opts)
      require("Comment").setup(opts)

      vim.keymap.set("n", "<leader>/", function()
        return require("Comment.api").call(
          "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
          "g@$"
        )()
      end, { expr = true, silent = true, desc = "Comment line" })

      vim.keymap.set(
        "x",
        "<leader>/",
        "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
        { desc = "Comment line(s)" }
      )
    end,
  },
}
