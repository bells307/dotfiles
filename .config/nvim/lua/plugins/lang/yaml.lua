return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "yaml-language-server" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              format = {
                enable = true,
              },
              schemaStore = {
                enable = true,
              },
            },
          },
        },
      },
    },
  },
}
