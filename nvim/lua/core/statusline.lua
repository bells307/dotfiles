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

local mode_hls = {
	NORMAL = "SLModeNormal",
	["N-OP"] = "SLModeNormal",
	INSERT = "SLModeInsert",
	VISUAL = "SLModeVisual",
	["V-LINE"] = "SLModeVisual",
	["V-BLOCK"] = "SLModeVisual",
	SELECT = "SLModeVisual",
	["S-LINE"] = "SLModeVisual",
	["S-BLOCK"] = "SLModeVisual",
	REPLACE = "SLModeReplace",
	["V-REPLACE"] = "SLModeReplace",
	COMMAND = "SLModeCommand",
	TERMINAL = "SLModeOther",
	PROMPT = "SLModeOther",
}

local function setup_highlights()
	vim.api.nvim_set_hl(0, "SLModeNormal", { fg = "#1a1a2e", bg = "#a9dc76", bold = true })
	vim.api.nvim_set_hl(0, "SLModeInsert", { fg = "#1a1a2e", bg = "#78dce8", bold = true })
	vim.api.nvim_set_hl(0, "SLModeVisual", { fg = "#1a1a2e", bg = "#ab9df2", bold = true })
	vim.api.nvim_set_hl(0, "SLModeReplace", { fg = "#1a1a2e", bg = "#ff6188", bold = true })
	vim.api.nvim_set_hl(0, "SLModeCommand", { fg = "#1a1a2e", bg = "#ffd866", bold = true })
	vim.api.nvim_set_hl(0, "SLModeOther", { fg = "#1a1a2e", bg = "#fc9867", bold = true })
	vim.api.nvim_set_hl(0, "SLError", { link = "DiagnosticError" })
	vim.api.nvim_set_hl(0, "SLWarn", { link = "DiagnosticWarn" })
	vim.api.nvim_set_hl(0, "SLGit", { link = "String" })
	vim.api.nvim_set_hl(0, "SLLSPName", { link = "Function" })
	vim.api.nvim_set_hl(0, "SLDim", { link = "Comment" })
end

setup_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_highlights })

_G.SLMode = function()
	local mode = modes[vim.api.nvim_get_mode().mode] or "?"
	local hl = mode_hls[mode] or "SLModeOther"
	return "%#" .. hl .. "# " .. mode .. " %*"
end

_G.SLDiag = function()
	local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local parts = {}
	if e > 0 then
		parts[#parts + 1] = "%#SLError#E:" .. e .. "%*"
	end
	if w > 0 then
		parts[#parts + 1] = "%#SLWarn#W:" .. w .. "%*"
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
	local parts = { "%#SLGit# " .. d.head .. "%*" }
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

local lsp_loading = {}
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
		local icon = lsp_loading[c.id] and spinner_frames[spinner_idx] or "⣿"
		parts[#parts + 1] = "%#SLLSPName#" .. c.name .. "%* " .. icon
	end
	return table.concat(parts, ", ") .. " "
end

_G.SLFileInfo = function()
	local ft = vim.bo.filetype
	local enc = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.bo.encoding
	local fmt = vim.bo.fileformat
	local parts = {}
	if ft ~= "" then
		parts[#parts + 1] = ft
	end
	if enc ~= "utf-8" then
		parts[#parts + 1] = enc
	end
	if fmt ~= "unix" then
		parts[#parts + 1] = fmt
	end
	if #parts == 0 then
		return ""
	end
	return "%#SLDim#" .. table.concat(parts, " ") .. "%* "
end

_G.SLKBLayout = function()
	if vim.api.nvim_get_option_value("keymap", {}) == "" then
		return ""
	end
	local active = vim.api.nvim_get_option_value("iminsert", { buf = 0 }) ~= 0
	return (active and "[ru]" or "[en]") .. " "
end

vim.opt.statusline =
	"%{%v:lua.SLMode()%} %f %m%r %=%{%v:lua.SLLSP()%}%{%v:lua.SLDiag()%}%{%v:lua.SLGit()%}%{%v:lua.SLFileInfo()%}%{%v:lua.SLKBLayout()%}%l:%c %p%% "
