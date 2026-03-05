require("mason").setup({
	ui = { border = "rounded" },
})

local ensure_installed = { "lua-language-server", "stylua" }
local registry = require("mason-registry")
registry.refresh(function()
	for _, name in ipairs(ensure_installed) do
		local ok, pkg = pcall(registry.get_package, name)
		if ok and not pkg:is_installed() then
			pkg:install()
		end
	end
end)
