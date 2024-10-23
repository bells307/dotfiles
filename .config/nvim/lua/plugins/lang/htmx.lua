return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "htmx-lsp" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        htmx = {},
      },
    },
  },
}
