return {
	"mfussenegger/nvim-dap",
	lazy = true,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dap.configurations.java = {
			{
				name = "Debug launch (2GB)", -- configuration name
				type = "java", -- configuration type
				request = "launch", -- configuration request
				vmArgs = "-Xmx2G", -- configuration arguments
			},
			{
				name = "Debug Attach (5005)", -- configuration name
				type = "java", -- configuration type
				request = "attach", -- configuration request
				hostName = "127.0.0.1", -- configuration hostName
				port = 5005, -- configuration port
			},
			{
				name = "", -- configuration name
				type = "java", -- configuration type
				request = "attach", -- configuration request
				mainClass = "com.limarai.webservice.Application", -- configuration mainClass
				vmArgs = "-Xmx2G", -- configuration arguments
			},
		}

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
			---@diagnostic disable-next-line: missing-fields
			require("dapui").eval(nil, { enter = true })
		end)

		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F6>", dap.restart)
		vim.keymap.set("n", "<F7>", dap.close)
		-- setup debug
		vim.keymap.set("n", "<leader>b", ':lua require"dap".toggle_breakpoint()<CR>')
		vim.keymap.set("n", "<leader>B", ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
		vim.keymap.set("n", "<leader>bl", ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
		vim.keymap.set("n", "<leader>dr", ':lua require"dap".repl.open()<CR>')

		vim.keymap.set(
			"n",
			"<leader><leader>dc",
			"<cmd>Telescope dap commands<CR>",
			{ desc = "Telescope dap commands" }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>dl",
			"<cmd>Telescope dap configurations<CR>",
			{ desc = "Telescope dap configurations" }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>db",
			"<cmd>Telescope dap list_breakpoints<CR>",
			{ desc = "Telescope dap list_breakpoints" }
		)
		vim.keymap.set(
			"n",
			"<leader><leader>dv",
			"<cmd>Telescope dap variables<CR>",
			{ desc = "Telescope dap variables" }
		)
		vim.keymap.set("n", "<leader><leader>df", "<cmd>Telescope dap frames<CR>", { desc = "Telescope dap frames" })

		-- view informations in debug
		local function show_dap_centered_scopes()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end

		vim.keymap.set("n", "gs", ":lua show_dap_centered_scopes()<CR>")
		-- require("telescope").load_extension("dap")
	end,
}
