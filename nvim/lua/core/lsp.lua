-- :h lsp-config

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(event)
		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			float = {
				border = "single", -- "single", "double", "shadow", "none"
			},
		})

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "Go to declaration" })
		vim.keymap.set("n", "<leader>fd", function()
			builtin.diagnostics({ bufnr = 0 })
		end, { buffer = event.buf, desc = "Diagnostics (buffer)" })
		vim.keymap.set("n", "<leader>fD", builtin.diagnostics, { buffer = event.buf, desc = "Diagnostics (workspace)" })
		vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = event.buf, desc = "Go to references" })
		vim.keymap.set("n", "gI", builtin.lsp_implementations, { buffer = event.buf, desc = "Go to implentations" })
		vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { buffer = event.buf, desc = "Type definition" })
		vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { buffer = event.buf, desc = "Document symbols" })
		vim.keymap.set(
			"n",
			"<leader>fS",
			builtin.lsp_dynamic_workspace_symbols,
			{ buffer = event.buf, desc = "Workspace symbols" }
		)
		vim.keymap.set("n", "<leader>fc", builtin.lsp_incoming_calls, { buffer = event.buf, desc = "Incoming calls" })
		vim.keymap.set("n", "<leader>fC", builtin.lsp_outgoing_calls, { buffer = event.buf, desc = "Outgoing calls" })

		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code action" })
		vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.refresh, { buffer = event.buf, desc = "CodeLens Refresh" })
		vim.keymap.set("n", "<leader>cR", vim.lsp.codelens.run, { buffer = event.buf, desc = "CodeLens Run" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover Documentation" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true)
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			end, "Toggle Inlay Hints")
		end
	end,
})

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('gopls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('taplo')
vim.lsp.enable('pyright')
vim.lsp.enable('jsonls')
vim.lsp.enable('nil_ls')
