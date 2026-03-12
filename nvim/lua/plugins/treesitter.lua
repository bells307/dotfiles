require("nvim-treesitter").install({
	"rust",
	"go",
	"lua",
	"vim",
	"vimdoc",
	"gitcommit",
	"git_rebase",
	"diff",
	"nix",
	"toml",
	"yaml",
	"json",
	"jsonc",
	"markdown",
	"markdown_inline",
	"bash",
	"regex",
	"comment",
})

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v",
			["@function.outer"] = "V",
		},
		include_surrounding_whitespace = false,
	},
	move = {
		set_jumps = true,
	},
})

vim.keymap.set({ "x", "o" }, "af", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aa", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "as", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end)

vim.keymap.set({ "n", "x", "o" }, "]f", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[f", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]F", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[F", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]c", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[c", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]C", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[C", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]a", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[a", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]A", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[A", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects")
end)

vim.keymap.set("n", "<leader>sa", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>sA", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.outer")
end)

require("treesitter-context").setup({ enable = false })
vim.keymap.set("n", "<leader>tc", function()
	require("treesitter-context").toggle()
end)
