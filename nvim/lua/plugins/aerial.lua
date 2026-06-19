require("aerial").setup({
	backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
	layout = {
		max_width = { 40, 0.2 },
		min_width = 30,
		default_direction = "left",
		placement = "edge",
	},
	show_guides = true,
	attach_mode = "window",
	autojump = true,
	post_jump_cmd = "normal! zt",
})

require("telescope").load_extension("aerial")

vim.keymap.set("n", "<leader>fs", "<cmd>Telescope aerial<cr>", { desc = "Symbols" })
vim.keymap.set("n", "<leader><leader>", "<cmd>AerialToggle<cr>", { desc = "Symbols outline" })
vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { desc = "Prev symbol" })
vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { desc = "Next symbol" })
vim.keymap.set("n", "[{", function()
	require("aerial").prev_up()
end, { desc = "Parent symbol (prev)" })
vim.keymap.set("n", "]}", function()
	require("aerial").next_up()
end, { desc = "Parent symbol (next)" })
