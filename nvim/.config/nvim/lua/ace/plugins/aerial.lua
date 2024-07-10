return {
	"stevearc/aerial.nvim",
	opts = {},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,

			layout = {
				-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
				max_width = { 40, 0.2 },
				width = nil,
				min_width = 30,
			},
		})
		vim.keymap.set("n", ",a", "<cmd>AerialToggle!<CR>")
	end,
}
