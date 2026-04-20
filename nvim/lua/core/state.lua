-- Persistent state stored as JSON in stdpath("data")/nvim-state.json
local state_file = vim.fn.stdpath("data") .. "/nvim-state.json"

local M = {}
local data = {}

local function load()
	local ok, lines = pcall(vim.fn.readfile, state_file)
	if ok and lines[1] then
		local decoded = vim.json.decode(table.concat(lines, "\n"))
		if decoded then
			data = decoded
		end
	end
end

local function save()
	vim.fn.writefile({ vim.json.encode(data) }, state_file)
end

function M.get(key, default)
	local v = data[key]
	if v ~= nil then
		return v
	end
	return default
end

function M.set(key, value)
	data[key] = value
	save()
end

load()

vim.keymap.set("n", "<leader>tC", function()
	vim.fn.writefile({ "{}" }, state_file)
	vim.notify("State cleared (restart to apply)", vim.log.levels.INFO)
end, { desc = "Clear persistent state" })

return M
