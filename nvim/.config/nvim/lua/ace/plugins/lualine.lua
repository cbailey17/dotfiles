return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		-- "nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
		{ "abeldekat/harpoonline", version = "*" },
	},
	config = function()
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- Harpoon integration
		local Harpoonline = require("harpoonline")
		Harpoonline.setup({
			on_update = function()
				require("lualine").refresh()
			end,
		})

		local colors = {
			-- blue = "#65D1FF",
			blue = "#2cF9ed",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
		}

		-- Custom theme with colors borrowed from https://github.com/josean-dev
		local custom_bubbles_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		-- Set up lualine sections
		require("lualine").setup({
			options = {
				theme = custom_bubbles_theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = {
					{
						"filename",
						path = 1,
						symbols = {
							modified = "●",
							read_only = "󰌾",
						},
					},
					{ "branch" },
				},
				lualine_c = {
					"%=",
					{ Harpoonline.format },
					{ "buffers", mode = 4, symbols = { alternate_file = "󰑱 " } },
				},
				lualine_x = {
					{ require("mcphub.extensions.lualine") },
					{ lazy_status.updates, cond = lazy_status.has_updates, color = { fg = "#ff9e64" } },
				},
				lualine_y = { require("recorder").displaySlots, "filetype", "progress" },
				lualine_z = {
					{
						require("recorder").recordingStatus,
						"location",
						separator = { right = "" },
						left_padding = 2,
					},
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
