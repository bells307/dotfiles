return {
	-- Installs LSP servers, linters, formatters
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = { border = "rounded" },
		},
		config = function(_, opts)
			require("mason").setup(opts)

			-- Auto-install required tools
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
		end,
	},
}
