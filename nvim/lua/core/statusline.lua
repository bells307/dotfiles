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

local _layout_cache = ""
if vim.fn.executable("im-select") == 1 then
	local function update_layout()
		vim.system({ "im-select" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				return
			end
			local out = (obj.stdout or ""):gsub("%s+$", "")
			vim.schedule(function()
				if out:match("Russian") then
					_layout_cache = "RU"
				elseif out:match("ABC") or out:match("US") then
					_layout_cache = "EN"
				else
					local short = out:match("([^.]+)$") or out
					_layout_cache = short:sub(1, 4):upper()
				end
			end)
		end)
	end
	update_layout()
	vim.uv.new_timer():start(0, 1000, vim.schedule_wrap(update_layout))
end

_G.SLLayout = function()
	if _layout_cache == "" then
		return ""
	end
	return _layout_cache .. " "
end

_G.SLGitBranch = function()
	local branch = vim.b.gitsigns_head
	if not branch or branch == "" then
		return ""
	end
	return " " .. branch .. " "
end

vim.opt.statusline = "%{v:lua.SLMode()} %{v:lua.SLLayout()}%{v:lua.SLGitBranch()}%y %f %m%r%=%l:%c  %p%%"
