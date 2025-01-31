return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "yavorski/lualine-macro-recording.nvim" },
    },
    opts = {
      sections = {
        lualine_c = { { "macro_recording", "%S" }, { "filename", path = 1 } },
      },
    },
  },
}
