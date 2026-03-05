vim.lsp.config("*", {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- Keymaps and inlay hints applied on every LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
		end

		local builtin = require("telescope.builtin")

		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gD", vim.lsp.buf.declaration, "Go to declaration")
		map("<leader>fd", function()
			builtin.diagnostics({ bufnr = 0 })
		end, "Diagnostics (buffer)")
		map("<leader>fD", builtin.diagnostics, "Diagnostics (workspace)")
		map("gr", builtin.lsp_references, "Go to references")
		map("gI", builtin.lsp_implementations, "Go to implentations")
		map("gy", builtin.lsp_type_definitions, "Type definition")
		map("<leader>fs", builtin.lsp_document_symbols, "Document symbols")
		map("<leader>fS", builtin.lsp_dynamic_workspace_symbols, "Workspace symbols")
		map("<leader>fc", builtin.lsp_incoming_calls, "Incoming calls")
		map("<leader>fC", builtin.lsp_outgoing_calls, "Outgoing calls")
		map("<leader>cr", vim.lsp.buf.rename, "Rename")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("<leader>cl", vim.lsp.codelens.refresh, "CodeLens Refresh")
		map("<leader>cR", vim.lsp.codelens.run, "CodeLens Run")
		map("K", vim.lsp.buf.hover, "Hover Documentation")

		if vim.lsp.inlay_hint then
			map("<leader>th", function()
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
