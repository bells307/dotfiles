return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "pyright" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },
}
