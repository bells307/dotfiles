local telescope = require("telescope")
telescope.setup({
	defaults = {
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})
telescope.load_extension("fzf")
telescope.load_extension("ui-select")


local b = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", b.find_files, { desc = "Files (respecting .gitignore)" })
vim.keymap.set("n", "<leader>fF", function()
	b.find_files({ hidden = true, no_ignore = true })
end, { desc = "Files (all, including .gitignore)" })
vim.keymap.set("n", "<leader>f.", function()
	b.find_files({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "Files (current buffer directory)" })
vim.keymap.set("n", "<leader>fk", b.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fg", b.live_grep, { desc = "Grep" })
vim.keymap.set("n", "<leader>fh", b.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fo", b.oldfiles, { desc = "Old files" })
vim.keymap.set("n", "<leader>fj", b.jumplist, { desc = "Jumps" })
vim.keymap.set("n", "<leader>fb", b.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fG", b.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader>fr", b.resume, { desc = "Resume last search" })
vim.keymap.set("n", "<leader>ft", function()
	b.colorscheme({ enable_preview = true })
end, { desc = "Colorscheme picker" })
vim.keymap.set("n", "<leader>fn", function()
	b.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Nvim config files" })
