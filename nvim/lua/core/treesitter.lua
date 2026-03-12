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

vim.keymap.set("n", "<A-o>", function()
	ts_sel_history = {}
	local node = vim.treesitter.get_node()
	if not node then
		return
	end
	table.insert(ts_sel_history, node)
	ts_select_node(node)
end)

vim.keymap.set("x", "<A-o>", function()
	local last = ts_sel_history[#ts_sel_history]
	if not last then
		return
	end
	local parent = last:parent()
	if not parent then
		return
	end
	table.insert(ts_sel_history, parent)
	ts_select_node(parent)
end)

vim.keymap.set("x", "<A-i>", function()
	if #ts_sel_history <= 1 then
		return
	end
	table.remove(ts_sel_history)
	ts_select_node(ts_sel_history[#ts_sel_history])
end)
