return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function(_, opts)
      local fzf = require("fzf-lua")
      fzf.setup(opts)

      local map = vim.keymap.set

      map("n", "<leader>ff", fzf.files, { desc = "Files" })
      map("n", "<leader>f.", function()
        fzf.files({ cwd = vim.fn.expand("%:p:h") })
      end, { desc = "Files (current buffer directory)" })
      map("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
      map("n", "<leader>fg", fzf.live_grep, { desc = "Grep" })
      map("n", "<leader>fh", fzf.helptags, { desc = "Help tags" })
      map("n", "<leader>fo", fzf.oldfiles, { desc = "Old files" })
      map("n", "<leader>fj", fzf.jumps, { desc = "Jumps" })
      map("n", "<leader><leader>", fzf.buffers, { desc = "Buffers" })
      map("n", "<leader>fG", fzf.git_status, { desc = "Git status" })
    end,
  },
}
