-- lua/plugins/noice.lua
return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("notify").setup({
				stages = "fade_in_slide_out",
				timeout = 2500,
			})
			vim.notify = require("notify")

			require("noice").setup({
				lsp = {
					progress = { enabled = true },
					hover = { enabled = true },
					signature = { enabled = true },
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
				messages = {
					enabled = true,
					view = "notify",
					view_error = "notify",
					view_warn = "notify",
					view_history = "messages",
				},
				notify = {
					enabled = true,
					view = "notify",
				},
			})
		end,
	},
}
