return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    enabled = false,
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
    opts = {
      flavour = "frappe",
      -- transparent_background = true,
      integrations = {
        cmp = true,
        barbar = true,
        dropbar = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        native_lsp = {
          enabled = true,
        },
        neotree = true,
        noice = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
}
