require("conform").setup({
	formatters_by_ft = {
		rust = { "rustfmt" },
		lua = { "stylua" },
		sh = { "shfmt" },
		python = { "ruff_format" },
		json = { "jq" },
		jsonc = { "jq" },
		toml = { "taplo" },
		yaml = { "yamlfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
