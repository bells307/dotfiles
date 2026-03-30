require("kanagawa").setup({})

local function apply_colorscheme()
	if vim.o.background == "light" then
		vim.cmd.colorscheme("github_light_default")
	else
		vim.cmd.colorscheme("kanagawa")
	end
end

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = apply_colorscheme,
})

apply_colorscheme()
