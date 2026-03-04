-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins are loaded from lua/plugins/*.lua
-- Each file returns a table of plugin specs: { "author/repo", ...options }
-- See https://lazy.folke.io/ for full spec
require("lazy").setup({ { import = "plugins" } }, {
	ui = {
		border = "rounded",
	},
	checker = {
		enabled = true, -- auto-check for plugin updates
		notify = false, -- don't notify on startup
	},
	change_detection = {
		notify = false,
	},
})
