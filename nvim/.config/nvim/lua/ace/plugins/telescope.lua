return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		-- "nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
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
					"public/", -- temp
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
		telescope.load_extension("lazygit")
		telescope.load_extension("ui-select")
		telescope.load_extension("harpoon")
		telescope.load_extension("conflicts")
		telescope.load_extension("rest")
		telescope.load_extension("tailiscope")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local pickers = require("ace.telescopePickers")

		require("which-key").add({
			{
				{ "<leader>f", group = "Telescope" },
				{ "<leader>fG", "<cmd>Telescope conflicts<cr>", desc = "Find git conflicts" },
				{
					"<leader>fS",
					"<cmd>Telescope grep_string<cr>",
					desc = "Find string under cursor",
				},
				{ "<leader>fa", "<cmd>Telescope aerial<cr>", desc = "Telescope aerial" },
				{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
				{ "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Find color schemes" },
				{ "<leader>fd", "<cmd>Telescope lsp_document_symbols <cr>", desc = "Find buffers" },
				{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
				{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
				{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help" },
				{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Find jump list" },
				{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
				{ "<leader>fl", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
				{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find marks" },
				{ "<leader>fo", "<cmd>Lazy load obsidian.nvim | ObsidianSearch<CR>", desc = "Find Obsidian files" },
				{ "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Find registers" },
				{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find string" },
				{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
				{ "<leader>fw", "<cmd>Telescope lsp_document_symbols <cr>", desc = "Find buffers" },
				{ "<leader>tt", "<cmd>Telescope tailiscope<cr>", desc = "Find buffers" },
			},
		})
	end,
}
