return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = { cmd = { "marksman", "server" } },
      },
    },
  },
}
