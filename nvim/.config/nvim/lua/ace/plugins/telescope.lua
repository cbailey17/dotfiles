return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"Snikimonkd/telescope-git-conflicts.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local trouble = require("trouble")
		local open_with_trouble = require("trouble.sources.telescope").open

		local custom_actions = transform_mod({
			open_trouble_qflist = function()
				trouble.toggle("quickfix")
			end,
		})

		-- Formatting path display for telescope results
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "TelescopeResults",
			callback = function(ctx)
				vim.api.nvim_buf_call(ctx.buf, function()
					vim.fn.matchadd("TelescopeParent", "\t\t.*$")
					vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
				end)
			end,
		})

		local function filenameFirst(_, path)
			local tail = vim.fs.basename(path)
			local parent = vim.fs.dirname(path)
			if parent == "." then
				return tail
			end
			return string.format("\t%s\t\t%s", tail, parent)
		end

		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
					path_display = filenameFirst,
				},
				git_files = {
					hidden = true,
					path_display = filenameFirst,
				},
				oldfiles = {
					hidden = true,
					path_display = filenameFirst,
				},
				live_grep = {
					hidden = true,
					path_display = filenameFirst,
				},
				grep_string = {
					hidden = true,
					path_display = filenameFirst,
				},
				buffers = {
					hidden = true,
					path_display = filenameFirst,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
			defaults = {
				path_display = { "smart" },
				file_ignore_patterns = {
					".git/",
					"node_modules/",
					"yarn.lock",
					"package-lock.json",
					"undodir/",
					"venv/",
					"env/",
					".svn/",
					"go/",
					".local",
					".cache",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = open_with_trouble,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("harpoon")
		telescope.load_extension("conflicts")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local pickers = require("ace.telescopePickers")

		require("which-key").register({
			["<leader>f"] = {
				name = "Telescope",
				f = { "<cmd>Telescope find_files<cr>", "Find files" },
				g = { "<cmd>Telescope git_files<cr>", "Find git files" },
				l = { "<cmd>Telescope oldfiles<cr>", "Find recent files" },
				s = { "<cmd>Telescope live_grep<cr>", "Find string" },
				S = { "<cmd>Telescope grep_string<cr>", "Find string under cursor" },
				G = { "<cmd>Telescope conflicts<cr>", "Find git conflicts" },
				t = { "<cmd>TodoTelescope<cr>", "Find todos" },
				r = { "<cmd>Telescope registers<cr>", "Find registers" },
				j = { "<cmd>Telescope jumplist<cr>", "Find jump list" },
				c = { "<cmd>Telescope colorscheme<cr>", "Find color schemes" },
				m = { "<cmd>Telescope marks<cr>", "Find marks" },
				a = { "<cmd>Telescope aerial<cr>", "Telescope aerial" },
				o = { "<cmd>Lazy load obsidian.nvim | ObsidianSearch<CR>", "Find Obsidian files" },
				h = { "<cmd>Telescope help_tags<cr>", "Telescope help" },
				k = { "<cmd>Telescope keymaps<cr>", "Search keymaps" },
				b = { "<cmd>Telescope buffers<cr>", "Find buffers" },
				d = { "<cmd>Telescope lsp_document_symbols <cr>", "Find buffers" },
				w = { "<cmd>Telescope lsp_document_symbols <cr>", "Find buffers" },
			},
		})
	end,
}
