return {

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require("which-key").setup()

      -- Document existing key chains
      require("which-key").register({
        ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
        ["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
        ["<leader>t"] = { name = "Toggle", _ = "which_key_ignore" },
        ["<leader>u"] = { name = "UI", _ = "which_key_ignore" },
        ["<leader>b"] = { name = "Buffer", _ = "which_key_ignore" },
      })
    end,
  },
}
