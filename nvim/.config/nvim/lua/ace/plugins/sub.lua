return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local substitute = require("substitute")

		substitute.setup()

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		--
		-- keymap.set("n", "q", substitute.operator, { desc = "Substitute with motion" })
		-- keymap.set("n", "qq", substitute.line, { desc = "Substitute line" })
		-- keymap.set("n", "Q", substitute.eol, { desc = "Substitute to end of line" })
		-- keymap.set("x", "q", substitute.visual, { desc = "Substitute in visual mode" })
	end,
}
