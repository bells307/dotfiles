local state = require("core.state")

vim.g.transparent = state.get("transparent", true)

local function setup_highlights()
	-- '~' lines after EOF (always visible, dimmed)
	vim.api.nvim_set_hl(0, "EndOfBuffer", { link = "Comment" })

	if vim.g.transparent then
		-- main window background
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
		-- non-current window background
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
		-- floating windows (LSP hover, etc.)
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatBorder", { link = "Comment" })
		-- telescope floating window
		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
		-- telescope border
		vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
		-- input prompt area
		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
		-- results list area
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
		-- file preview area
		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		state.set("colorscheme", vim.g.colors_name)
		vim.schedule(setup_highlights)
	end,
})

vim.keymap.set("n", "<leader>tt", function()
	vim.g.transparent = not vim.g.transparent
	state.set("transparent", vim.g.transparent)
	vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = "Toggle transparency" })

vim.cmd.colorscheme(state.get("colorscheme", "kanagawa"))
