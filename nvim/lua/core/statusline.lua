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

local lsp_loading = {} -- client_id -> true when loading
local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
local spinner_idx = 1

vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(ev)
		local value = ev.data.params.value
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if value and value.kind == "end" then
			lsp_loading[ev.data.client_id] = nil
			vim.api.nvim_echo({ { "" } }, false, {})
		else
			if client then
				lsp_loading[ev.data.client_id] = true
				local msg = client.name
				if value and value.title and value.title ~= "" then
					msg = msg .. ": " .. value.title
				end
				if value and value.message and value.message ~= "" then
					msg = msg .. " — " .. value.message
				end
				if value and value.percentage then
					msg = msg .. " (" .. value.percentage .. "%)"
				end
				vim.api.nvim_echo({ { msg } }, false, {})
			end
		end
		vim.cmd.redrawstatus()
	end,
})

_G.SLLSP = function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end
	local any_loading = false
	for _, c in ipairs(clients) do
		if lsp_loading[c.id] then
			any_loading = true
			break
		end
	end
	if any_loading then
		spinner_idx = (spinner_idx % #spinner_frames) + 1
	end
	local parts = {}
	for _, c in ipairs(clients) do
		if lsp_loading[c.id] then
			parts[#parts + 1] = c.name .. " " .. spinner_frames[spinner_idx]
		else
			parts[#parts + 1] = c.name .. " ⣿"
		end
	end
	return table.concat(parts, ", ") .. " "
end

_G.SLKBLayout = function()
	if vim.api.nvim_get_option_value("keymap", {}) == "" then
		return ""
	end
	local active = vim.api.nvim_get_option_value("iminsert", { buf = 0 }) ~= 0
	return (active and "[ru]" or "[en]") .. " "
end

vim.opt.statusline =
	"%{v:lua.SLMode()} | %f %m%r%=%{v:lua.SLLSP()}%{v:lua.SLDiag()}%=%{v:lua.SLGit()}%=%{&fileencoding} %{&fileformat} %{&filetype} %{v:lua.SLKBLayout()}%=%l:%c  %p%%"
