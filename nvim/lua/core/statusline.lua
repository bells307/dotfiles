local modes = {
	n = "NORMAL",
	no = "N-OP",
	nov = "N-OP",
	noV = "N-OP",
	niI = "NORMAL",
	niR = "NORMAL",
	niV = "NORMAL",
	i = "INSERT",
	ic = "INSERT",
	ix = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	s = "SELECT",
	S = "S-LINE",
	["\19"] = "S-BLOCK",
	R = "REPLACE",
	Rc = "REPLACE",
	Rv = "V-REPLACE",
	Rx = "REPLACE",
	c = "COMMAND",
	cv = "COMMAND",
	r = "PROMPT",
	rm = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	t = "TERMINAL",
}

_G.SLMode = function()
	return modes[vim.api.nvim_get_mode().mode] or "?"
end

_G.SLDiag = function()
	local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local parts = {}
	if e > 0 then
		parts[#parts + 1] = "E:" .. e
	end
	if w > 0 then
		parts[#parts + 1] = "W:" .. w
	end
	if #parts == 0 then
		return ""
	end
	return table.concat(parts, " ") .. " "
end

_G.SLGit = function()
	local d = vim.b.gitsigns_status_dict
	if not d then
		return ""
	end
	local parts = { " " .. d.head }
	if (d.added or 0) > 0 then
		parts[#parts + 1] = "+" .. d.added
	end
	if (d.changed or 0) > 0 then
		parts[#parts + 1] = "~" .. d.changed
	end
	if (d.removed or 0) > 0 then
		parts[#parts + 1] = "-" .. d.removed
	end
	return table.concat(parts, " ") .. " "
end

_G.SLKBLayout = function()
	if vim.api.nvim_get_option_value("keymap", {}) == "" then
		return ""
	end
	local active = vim.api.nvim_get_option_value("iminsert", { buf = 0 }) ~= 0
	return (active and "[ru]" or "[en]") .. " "
end

vim.opt.statusline =
	"%{v:lua.SLMode()} | %f %m%r %{v:lua.SLDiag()}%=%{v:lua.SLGit()}%=%{&fileencoding} %{&fileformat} %{&filetype} %{v:lua.SLKBLayout()}%=%l:%c  %p%%"
