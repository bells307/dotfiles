-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.ansible" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.fish" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.file-explorer.mini-files" },
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  { import = "astrocommunity.terminal-integration.vim-tmux-navigator" },
  { import = "astrocommunity.recipes.telescope-nvchad-theme" },
  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
  -- import/override with your plugins folder
}
