local sessions_dir = vim.fn.stdpath("state") .. "/sessions"
vim.fn.mkdir(sessions_dir, "p")

local function session_file()
	local cwd = vim.fn.getcwd()
	local name = cwd:gsub("/", "%%") .. ".vim"
	return sessions_dir .. "/" .. name
end

local function save()
	local file = session_file()
	local ok, err = pcall(function() vim.cmd("mksession! " .. vim.fn.fnameescape(file)) end)
	if not ok then
		vim.notify("Session save failed: " .. err, vim.log.levels.ERROR)
	end
end

local function restore()
	local file = session_file()
	if vim.fn.filereadable(file) == 1 then
		vim.cmd("source " .. vim.fn.fnameescape(file))
	end
end

local group = vim.api.nvim_create_augroup("Session", { clear = true })

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = group,
	callback = save,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	nested = true,
	callback = function()
		-- only restore if nvim was opened with no file arguments
		if vim.fn.argc() == 0 then
			restore()
		end
	end,
})
