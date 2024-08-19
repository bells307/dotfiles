return {
  -- {
  --   "numToStr/FTerm.nvim",
  --   opts = {
  --     border = "double",
  --     dimensions = {
  --       height = 0.9,
  --       width = 0.9,
  --     },
  --   },
  --   config = function(opts)
  --     require("FTerm").setup(opts)
  --     vim.keymap.set("n", "<C-_>", '<CMD>lua require("FTerm").toggle()<CR>')
  --     vim.keymap.set("t", "<C-_>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
  --   end,
  -- },
  "voldikss/vim-floaterm",
  config = function(_)
    vim.keymap.set("n", "<C-_>", "<CMD>FloatermToggle<CR>")
    vim.keymap.set("t", "<C-_>", "<C-\\><C-n><CMD>FloatermToggle<CR>")
  end,
}
