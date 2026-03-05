return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},
	cmd = "Telescope",
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Files (respecting .gitignore)",
		},
		{
			"<leader>fF",
			function()
				require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
			end,
			desc = "Files (all, including .gitignore)",
		},
		{
			"<leader>f.",
			function()
				require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
			end,
			desc = "Files (current buffer directory)",
		},
		{
			"<leader>fk",
			function()
				require("telescope.builtin").keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Help tags",
		},
		{
			"<leader>fo",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Old files",
		},
		{
			"<leader>fj",
			function()
				require("telescope.builtin").jumplist()
			end,
			desc = "Jumps",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fG",
			function()
				require("telescope.builtin").git_status()
			end,
			desc = "Git status",
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").resume()
			end,
			desc = "Resume last search",
		},
		{
			"<leader>ft",
			function()
				require("telescope.builtin").colorscheme({ enable_preview = true })
			end,
			desc = "Colorscheme picker",
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}
