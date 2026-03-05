require("oil").setup({
	default_file_explorer = true,
	keymaps = {
		["q"] = { "actions.close", mode = "n" },
	},
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
