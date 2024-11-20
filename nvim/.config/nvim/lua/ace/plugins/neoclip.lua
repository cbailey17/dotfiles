return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "kkharji/sqlite.lua", module = "sqlite" },
		{ "nvim-telescope/telescope.nvim" },
		-- {'ibhagwan/fzf-lua'},
	},
	config = function()
		require("neoclip").setup({})
		local opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap("n", "<Leader>hh", "<cmd>Telescope neoclip<CR>", opts)
	end,
}
