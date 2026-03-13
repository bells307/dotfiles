local M = {}

function M.log(msg)
	local str = tostring(msg)
	local space = vim.fn.eval("v:echospace")
	vim.api.nvim_echo({ { str:sub(1, space), "" } }, false, {})
end

return M
