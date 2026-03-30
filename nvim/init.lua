vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind == "delete" then
			return
		end

		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end

		if name == "telescope-fzf-native.nvim" then
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		end
	end,
})

vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/folke/tokyonight.nvim",
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/Mofiqul/vscode.nvim",
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/sainnhe/everforest",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/saecki/crates.nvim",
	"https://github.com/smoka7/hop.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
})

require("core.options")
-- require("core.session")
require("core.keymaps")
require("core.statusline")
require("core.lsp")
require("core.treesitter")

require("plugins.colorschemes")
require("plugins.autopairs")
require("plugins.conform")
require("plugins.crates")
require("plugins.gitsigns")
require("plugins.oil")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.hop")
require("plugins.tmux-navigator")
