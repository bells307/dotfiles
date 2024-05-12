return {
  {
    "ggandor/leap.nvim",
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },
  -- {
  --   "ggandor/flit.nvim",
  --   enabled = true,
  --   keys = function()
  --     ---@type LazyKeys[]
  --     local ret = {}
  --     for _, key in ipairs({ "f", "F", "t", "T" }) do
  --       ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
  --     end
  --     return ret
  --   end,
  --   opts = { labeled_modes = "nx" },
  -- },
  { "tpope/vim-repeat", event = "VeryLazy" },
}
