return {
	"debugloop/telescope-undo.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	keys = {
		{
			"<leader>fu",
			"<cmd>Telescope undo<cr>",
			desc = "undo history",
		},
	},
	opts = {
		extensions = {
			undo = {
				-- telescope-undo.nvim config, see below
			},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("undo")
	end,
}
