return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

    dap.configurations.java = {
      {
        name="Debug launcg (2GB)", -- configuration name
        type="java", -- configuration type
        request="launch", -- configuration request
        vmArgs = "-Xmx2G", -- configuration arguments
      },
      {
        name="Debug Attach (8000)", -- configuration name
        type="java", -- configuration type
        request="attach", -- configuration request
        hostName="127.0.0.1", -- configuration hostName
        port=8000, -- configuration port
      },
      {
        name="Debug Attach (5005)", -- configuration name
        type="java", -- configuration type
        request="attach", -- configuration request
        hostName="127.0.0.1", -- configuration hostName
        port=5005, -- configuration port
      },
      {
        name="", -- configuration name
        type="java", -- configuration type
        request="attach", -- configuration request
        mainClass="com.example.Main", -- configuration mainClass
        vmArgs = "-Xmx2G", -- configuration arguments
      },
    }

		local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(path)

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🛑", texthl = "LspDiagnosticsSignError", linehl = "", numhl = "" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "🔵", texthl = "LspDiagnosticsSignHint", linehl = "", numhl = "" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "👉", texthl = "LspDiagnosticsSignInformation", linehl = "debugPC", numhl = "debugPC" }
		)

		-- DAP UI setup
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

		-- Eval var under cursor
		vim.keymap.set("n", "<space>?", function()
			require("dapui").eval(nil, { enter = true })
		end)

		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F6>", dap.restart)
		vim.keymap.set("n", "<F7>", dap.close)
	end,
}
