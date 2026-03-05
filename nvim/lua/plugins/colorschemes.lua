return {
	{ "folke/tokyonight.nvim", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "navarasu/onedark.nvim", lazy = true },
	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "sainnhe/everforest", lazy = true },
	{ "Mofiqul/vscode.nvim", lazy = true },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
}
