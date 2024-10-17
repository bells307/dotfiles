return {
  -- "voldikss/vim-floaterm",
  -- config = function(_)
  --   vim.keymap.set("n", "<C-_>", "<CMD>FloatermToggle<CR>")
  --   vim.keymap.set("t", "<C-_>", "<C-\\><C-n><CMD>FloatermToggle<CR>")
  -- end,

  "akinsho/toggleterm.nvim",
  opts = {
    -- size = 10,
    open_mapping = { [[<c-/>]], [[<c-_>]] },
    direction = "float",
    float_opts = {
      border = "curved",
    },
  },
}
