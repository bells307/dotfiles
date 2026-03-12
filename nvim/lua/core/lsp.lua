local function bisect_left(refs, line, col)
	local l, r = 1, #refs + 1
	while l < r do
		local m = l + math.floor((r - l) / 2)
		local rl, rc = refs[m].range.start.line, refs[m].range.start.character
		if rl < line or (rl == line and rc <= col) then
			l = m + 1
		else
			r = m
		end
	end
	return l
end

local function goto_reference(direction)
	local bufnr = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_get_current_win()
	local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
	local enc = client and client.offset_encoding or "utf-16"
	local pos_params = vim.lsp.util.make_position_params(win, enc)
	local params = {
		textDocument = pos_params.textDocument,
		position = pos_params.position,
		context = { includeDeclaration = true },
	}
	vim.lsp.buf_request(bufnr, "textDocument/references", params, function(err, result)
		if err or not result or #result == 0 then
			return
		end
		local uri = vim.uri_from_bufnr(bufnr)
		local refs = vim.tbl_filter(function(r)
			return r.uri == uri
		end, result)
		if #refs == 0 then
			return
		end
		table.sort(refs, function(a, b)
			local al, bl = a.range.start.line, b.range.start.line
			if al ~= bl then
				return al < bl
			end
			return a.range.start.character < b.range.start.character
		end)
		local cur = vim.api.nvim_win_get_cursor(win)
		local cur_line, cur_col = cur[1] - 1, cur[2]
		local i = bisect_left(refs, cur_line, cur_col)
		if direction == "next" then
			if i > #refs then
				i = 1
			end
		else
			i = i - 1
			if i == 0 then
				i = #refs
			end
		end
		local target = refs[i]
		vim.cmd("normal! m`")
		vim.api.nvim_win_set_cursor(win, { target.range.start.line + 1, target.range.start.character })
	end)
end

vim.lsp.config("*", {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- Keymaps and inlay hints applied on every LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local map = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
		end

		-- Enable completions
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, ev.data.client_id, bufnr, { autotrigger = true })
		end

		local builtin = require("telescope.builtin")

		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "<leader>fd", function()
			builtin.diagnostics({ bufnr = 0 })
		end, "Diagnostics (buffer)")
		map("n", "<leader>fD", builtin.diagnostics, "Diagnostics (workspace)")
		map("n", "gr", builtin.lsp_references, "Go to references")
		map("n", "gI", builtin.lsp_implementations, "Go to implentations")
		map("n", "gy", builtin.lsp_type_definitions, "Type definition")
		map("n", "<leader>fs", builtin.lsp_document_symbols, "Document symbols")
		map("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols, "Workspace symbols")
		map("n", "<leader>fc", builtin.lsp_incoming_calls, "Incoming calls")
		map("n", "<leader>fC", builtin.lsp_outgoing_calls, "Outgoing calls")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>cl", vim.lsp.codelens.refresh, "CodeLens Refresh")
		map("n", "<leader>cR", vim.lsp.codelens.run, "CodeLens Run")
		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")

		map("n", "]]", function()
			goto_reference("next")
		end, "Next reference usage")
		map("n", "[[", function()
			goto_reference("prev")
		end, "Prev reference usage")

		if vim.lsp.inlay_hint then
			map("n", "<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
			end, "Toggle inlay hints")
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end,
})

-- Diagnostics appearance
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		source = "if_many",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
})

-- Enable servers (reads config from lsp/<name>.lua in runtimepath)
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("bash_ls")
