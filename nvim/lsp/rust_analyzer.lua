local function on_attach(client, bufnr)
	local function goto_location(location)
		local uri = location.uri or location.targetUri
		local range = location.range or location.targetSelectionRange
		vim.cmd("edit " .. vim.fn.fnameescape(vim.uri_to_fname(uri)))
		if range then
			vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
		end
	end

	-- Parent module
	vim.keymap.set("n", "<leader>rp", function()
		local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
		vim.lsp.buf_request(bufnr, "experimental/parentModule", params, function(err, result)
			if err then
				vim.notify("Parent module error: " .. err.message, vim.log.levels.ERROR)
				return
			end
			if not result or #result == 0 then
				vim.notify("No parent module found", vim.log.levels.WARN)
				return
			end
			goto_location(result[1])
		end)
	end, { buffer = bufnr, desc = "LSP: Parent module" })

	-- Open Cargo.toml
	vim.keymap.set("n", "<leader>rc", function()
		local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }
		vim.lsp.buf_request(bufnr, "experimental/openCargoToml", params, function(err, result)
			if err then
				vim.notify("Open Cargo.toml error: " .. err.message, vim.log.levels.ERROR)
				return
			end
			if not result then
				vim.notify("Cargo.toml not found", vim.log.levels.WARN)
				return
			end
			goto_location(result)
		end)
	end, { buffer = bufnr, desc = "LSP: Open Cargo.toml" })

	-- Reload workspace
	vim.keymap.set("n", "<leader>rr", function()
		vim.lsp.buf_request(bufnr, "rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				vim.notify("Reload error: " .. err.message, vim.log.levels.ERROR)
				return
			end
			vim.notify("Workspace reloaded", vim.log.levels.INFO)
		end)
	end, { buffer = bufnr, desc = "LSP: Reload workspace" })

	-- Expand macro
	vim.keymap.set("n", "<leader>rm", function()
		local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
		vim.lsp.buf_request(bufnr, "rust-analyzer/expandMacro", params, function(err, result)
			if err then
				vim.notify("Macro expand error: " .. err.message, vim.log.levels.ERROR)
				return
			end
			if not result then
				vim.notify("No macro found at cursor", vim.log.levels.WARN)
				return
			end
			local lines = vim.split(result.expansion, "\n")
			vim.cmd("botright new")
			local buf = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			vim.bo[buf].filetype = "rust"
			vim.bo[buf].modifiable = false
			vim.bo[buf].buftype = "nofile"
			vim.bo[buf].bufhidden = "wipe"
			vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf })
		end)
	end, { buffer = bufnr, desc = "LSP: Expand macro" })
end

return {
	cmd = { "rust-analyzer" },
	on_attach = on_attach,
	root_dir = vim.fs.dirname(vim.fs.find({ "Cargo.toml" }, { upward = true })[1]),
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				buildScripts = {
					enable = true,
				},
			},
			checkOnSave = true,
			procMacro = {
				enable = true,
				ignored = {
					["async-trait"] = { "async_trait" },
					["napi-derive"] = { "napi" },
					["async-recursion"] = { "async_recursion" },
				},
			},
		},
	},
}
