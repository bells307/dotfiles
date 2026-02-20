return {
	"stevearc/aerial.nvim",
	opts = {
		on_attach = function(bufnr)
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		end,
	},
	keys = {
		{
			"<leader>a",
			"<cmd>AerialToggle!<CR>",
			desc = "Aerial toggle",
			noremap = true,
			silent = true,
		},
	},
}
