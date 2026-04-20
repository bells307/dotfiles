vim.g.transparent = true

local function setup_highlights()
	-- '~' lines after EOF (always visible, dimmed)
	vim.api.nvim_set_hl(0, "EndOfBuffer", { link = "Comment" })

	if not vim.g.transparent then
		return
	end

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

local current_light, current_dark

local function apply_colorscheme(light, dark)
	current_light = light or current_light
	current_dark = dark or current_dark
	local target = vim.o.background == "light" and current_light or current_dark
	if vim.g.colors_name ~= target then
		vim.cmd.colorscheme(target)
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		if vim.o.background == "light" then
			current_light = vim.g.colors_name
		else
			current_dark = vim.g.colors_name
		end
		vim.schedule(setup_highlights)
	end,
})

-- re-apply colorscheme when 'background' is changed by the user (e.g. system theme toggle)
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		vim.schedule(apply_colorscheme)
	end,
})

vim.keymap.set("n", "<leader>tt", function()
	vim.g.transparent = not vim.g.transparent
	vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = "Toggle transparency" })

apply_colorscheme("github_light_default", "kanagawa")
