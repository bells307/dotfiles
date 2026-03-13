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
vim.lsp.enable("pyright")
vim.lsp.enable("jsonls")
vim.lsp.enable("taplo")
vim.lsp.enable("yamlls")
