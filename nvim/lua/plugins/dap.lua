local dap = require("dap")
local dapui = require("dapui")

local codelldb_path = vim.fn.expand("~/.local/share/codelldb/extension/adapter/codelldb")

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb_path,
		args = { "--port", "${port}" },
	},
}

dap.configurations.rust = {
	{
		name = "Launch binary",
		type = "codelldb",
		request = "launch",
		program = function()
			-- Try to find the binary in target/debug/
			local cwd = vim.fn.getcwd()
			local cargo_toml = cwd .. "/Cargo.toml"
			if vim.fn.filereadable(cargo_toml) == 1 then
				-- Read package name from Cargo.toml
				for line in io.lines(cargo_toml) do
					local name = line:match('^name%s*=%s*"([^"]+)"')
					if name then
						local bin = cwd .. "/target/debug/" .. name
						if vim.fn.executable(bin) == 1 then
							return bin
						end
					end
				end
			end
			return vim.fn.input("Binary path: ", cwd .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
	{
		name = "Debug unit test",
		type = "codelldb",
		request = "launch",
		program = function()
			-- Compile tests without running, capture the test binary path
			local output = vim.fn.system("cargo test --no-run --message-format=json 2>/dev/null")
			local bin
			for line in output:gmatch("[^\n]+") do
				local exe = line:match('"executable":"([^"]+)"')
				if exe then
					bin = exe
				end
			end
			if not bin then
				vim.notify("cargo test --no-run failed", vim.log.levels.ERROR)
				return nil
			end
			return bin
		end,
		args = function()
			local filter = vim.fn.input("Test filter (empty = all): ")
			local args = { "--nocapture" }
			if filter ~= "" then
				table.insert(args, 1, filter)
			end
			return args
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
	{
		name = "Attach to process",
		type = "codelldb",
		request = "attach",
		pid = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}

-- DAP UI
dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.40 },
				{ id = "breakpoints", size = 0.15 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.20 },
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 12,
			position = "bottom",
		},
	},
})

-- Auto-open/close UI with debug session
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Virtual text (variable values inline)
require("nvim-dap-virtual-text").setup({})

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>dc", function()
	dap.continue()
end, { desc = "DAP: Continue" })
map("n", "<leader>do", function()
	dap.step_over()
end, { desc = "DAP: Step over" })
map("n", "<leader>di", function()
	dap.step_into()
end, { desc = "DAP: Step into" })
map("n", "<leader>dO", function()
	dap.step_out()
end, { desc = "DAP: Step out" })
map("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "DAP: Toggle breakpoint" })
map("n", "<leader>du", function()
	dapui.toggle()
end, { desc = "DAP: Toggle UI" })
map("n", "<leader>de", function()
	dapui.eval()
end, { desc = "DAP: Eval expression" })
map("v", "<leader>de", function()
	dapui.eval()
end, { desc = "DAP: Eval selection" })
map("n", "<leader>dx", function()
	dap.terminate()
end, { desc = "DAP: Terminate" })
