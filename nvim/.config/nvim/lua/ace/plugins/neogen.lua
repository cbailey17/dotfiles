return {
	"danymat/neogen",
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip",
			enabled = true,
			languages = {
				lua = {
					template = {
						annotation_convention = "ldoc",
					},
				},
				python = {
					template = {
						annotation_convention = "google_docstrings",
					},
				},
				rust = {
					template = {
						annotation_convention = "rustdoc",
					},
				},
				javascript = {
					template = {
						annotation_convention = "jsdoc",
					},
				},
				typescript = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
				typescriptreact = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
			},
		})
		local opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap("n", "<Leader>nm", ":lua require('neogen').generate()<CR>", opts)
		vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'file' })<CR>", {})
		vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", {})
	end,
}
