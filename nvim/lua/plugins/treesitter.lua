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

vim.g.no_plugin_maps = true

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

vim.keymap.set("n", "<leader>sa", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>sA", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.outer")
end)

-- Incremental treesitter selection
local ts_sel_history = {}

local function ts_select_node(node)
	local sr, sc, er, ec = node:range()
	local last_col
	if ec == 0 and er > 0 then
		er = er - 1
		last_col = math.max(0, #vim.api.nvim_buf_get_lines(0, er, er + 1, false)[1] - 1)
	else
		last_col = math.max(0, ec - 1)
	end
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" or mode == "\22" then
		local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		vim.api.nvim_feedkeys(esc, "nx", false)
	end
	vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
	vim.cmd("normal! v")
	vim.api.nvim_win_set_cursor(0, { er + 1, last_col })
end

vim.keymap.set("n", "<Tab>", function()
	ts_sel_history = {}
	local node = vim.treesitter.get_node()
	if not node then return end
	table.insert(ts_sel_history, node)
	ts_select_node(node)
end)

vim.keymap.set("x", "<Tab>", function()
	local last = ts_sel_history[#ts_sel_history]
	if not last then return end
	local parent = last:parent()
	if not parent then return end
	table.insert(ts_sel_history, parent)
	ts_select_node(parent)
end)

vim.keymap.set("x", "<S-Tab>", function()
	if #ts_sel_history <= 1 then return end
	table.remove(ts_sel_history)
	ts_select_node(ts_sel_history[#ts_sel_history])
end)

require("treesitter-context").setup()
vim.keymap.set("n", "<leader>tc", function()
	require("treesitter-context").toggle()
end)
