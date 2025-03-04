return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
  -- stylua: ignore
  keys = {
    { "m",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "<leader>v",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "<leader>r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "<leader>ts",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<leader>tf", mode = { "n", "v" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
