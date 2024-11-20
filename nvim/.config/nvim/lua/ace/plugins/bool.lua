return {
	"nat-418/boole.nvim",
	config = function()
		require("boole").setup({
			mappings = {
				increment = "<C-a>",
				decrement = "<C-s>",
			},
			-- User defined loops
			additions = {
				{ "void", "int", "char", "float", "double" },
				{ "Integer", "String", "Char", "Boolean", "Float" },
				{ "public", "private" },
				{ "List", "HashMap", "ArrayList", "Map" },
				{ "<", "<=", ">", ">=" },
			},
			allow_caps_additions = {
				{ "enable", "disable" },
				-- enable → disable
				-- Enable → Disable
				-- ENABLE → DISABLE
			},
		})
	end,
}
