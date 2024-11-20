return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim", "j-hui/fidget.nvim" },
		opts = {
			cmd = { "REST" },
		},
		config = function()
			vim.g.rest_nvim = {}
		end,
	},
}
