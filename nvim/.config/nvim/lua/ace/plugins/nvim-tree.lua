return {
	"nvim-tree/nvim-tree.lua",
	lazy = true,
	-- dependencies = "nvim-tree/nvim-web-devicons",
	dependencies = "echasnovski/mini.icons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		vim.cmd([[
      :hi      NvimTreeFolderName    guifg=#2cf9ed
      :hi      NvimTreeFolderIcon    guifg=#2cf9ed
      :hi      NvimTreeClosedFolderIcon    guifg=#2cf9ed
      :hi      NvimTreeOpenFolderIcon    guifg=#2cf9ed
      :hi      NvimTreeEmptyFolderName    guifg=#2cf9ed
      :hi      NvimTreeOpenedFolderName    guifg=#2cf9ed
      :hi      NvimTreeCursorLineNr    guifg=#cd0951
    ]])

		nvimtree.setup({
			view = {
				width = 45,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
