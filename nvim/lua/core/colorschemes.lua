vim.g.transparent = true

local function setup_highlights()
	local function hl_fg(name)
		local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
		return hl.fg and string.format("#%06x", hl.fg) or nil
	end

	-- '~' lines after EOF (always visible, dimmed)
	vim.api.nvim_set_hl(0, "EndOfBuffer", { link = "Comment" })

	if not vim.g.transparent then
		return
	end

	local norm_fg = hl_fg("Normal")
	local spec_fg = hl_fg("Special")

	-- main window background
	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
	-- non-current window background
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
	-- floating windows (LSP hover, etc.)
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = norm_fg })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = spec_fg })
	-- telescope floating window
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE", fg = norm_fg })
	-- telescope border
	vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", fg = spec_fg })
	-- input prompt area
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE", fg = norm_fg })
	-- results list area
	vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE", fg = norm_fg })
	-- file preview area
	vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
end

local current_light, current_dark

local function apply_colorscheme(light, dark)
	current_light = light or current_light
	current_dark = dark or current_dark
	if vim.o.background == "light" then
		vim.cmd.colorscheme(current_light)
	else
		vim.cmd.colorscheme(current_dark)
	end
end

-- re-apply transparent highlights after any colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.schedule(setup_highlights)
	end,
})

-- re-apply colorscheme when 'background' is changed (e.g. by system theme toggle)
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		apply_colorscheme()
	end,
})

vim.keymap.set("n", "<leader>tt", function()
	vim.g.transparent = not vim.g.transparent
	vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = "Toggle transparency" })

apply_colorscheme("github_light_default", "kanagawa")
