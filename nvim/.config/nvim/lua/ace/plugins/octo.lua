return {
	"pwntester/octo.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"echasnovski/mini.icons",
	},
	config = function()
		require("octo").setup()
	end,
	keys = {
		{ "<leader>pr", mode = { "n", "x", "o" }, "<cmd>Octo pr list<CR>", desc = "Open PRs" },
		-- { "S",     mode = { "n", "x", "o" }, function() require("octo").pr() end,                 desc = "Pull Request" },
		-- { "r",     mode = "o",               function() require("octo").review() end,              desc = "Review" },
		-- { "R",     mode = { "o", "x" },      function() require("octo").review_thread() end,      desc = "Review Thread" },
		-- { "<c-s>", mode = { "c" },           function() require("octo").search() end,              desc = "Search" },
	},
}
