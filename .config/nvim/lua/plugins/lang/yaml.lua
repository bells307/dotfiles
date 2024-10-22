return {
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
