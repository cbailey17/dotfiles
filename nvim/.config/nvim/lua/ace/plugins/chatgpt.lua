return {
	"jackmort/chatgpt.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("chatgpt").setup()

		local wk = require("which-key")
		wk.add({
			{ "<leader>cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
			{
				"<leader>ci",
				"<cmd>ChatGPTEditWithInstruction<CR>",
				desc = "Edit with instruction",
				mode = { "n", "v" },
			},
			{
				"<leader>cg",
				"<cmd>ChatGPTRun grammar_correction<CR>",
				desc = "Grammar Correction",
				mode = { "n", "v" },
			},
			{ "<leader>cr", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
			{ "<leader>ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
			{ "<leader>cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
			{ "<leader>ct", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
			{ "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
			{ "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
			{ "<leader>cb", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
			{ "<leader>ce", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
			{ "<leader>cR", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", mode = { "n", "v" } },
			{
				"<leader>ca",
				"<cmd>ChatGPTRun code_readability_analysis<CR>",
				desc = "Code Readability Analysis",
				mode = { "n", "v" },
			},
		})
	end,
}
