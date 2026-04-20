vim.g.transparent = true

local function apply_colorscheme()
	vim.cmd("highlight clear")
	if vim.o.background == "light" then
		vim.cmd.colorscheme("github_light_default")
	else
		require("kanagawa").setup({ transparent = vim.g.transparent })
		vim.cmd.colorscheme("kanagawa")
	end
	if vim.g.transparent then
		-- main window background
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
		-- non-current window background
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })

		-- '~' lines after EOF
		vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#938AA9" })

		local function hl_fg(name)
			local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
			return hl.fg and string.format("#%06x", hl.fg) or nil
		end
		-- telescope floating window
		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE", fg = hl_fg("Normal") })
		-- telescope border
		vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", fg = hl_fg("Special") })
		-- input prompt area
		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE", fg = hl_fg("Normal") })
		-- results list area
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE", fg = hl_fg("Normal") })
		-- file preview area
		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
	end
end

-- re-apply colorscheme when 'background' is changed (e.g. by system theme toggle)
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = apply_colorscheme,
})

vim.keymap.set("n", "<leader>tt", function()
	vim.g.transparent = not vim.g.transparent
	apply_colorscheme()
end, { desc = "Toggle transparency" })

apply_colorscheme()
