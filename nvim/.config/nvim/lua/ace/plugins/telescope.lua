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
    "SalOrak/whaler",
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
        },
        oldfiles = {
          hidden = true,
        },
        live_grep = {
          hidden = true,
        },
        grep_string = {
          hidden = true,
        },
      },
      extensions = {
        whaler = {
          -- Whaler configuration
          directories = {
            -- { path = "/home/acbailey/dotfiles/nvim/.config/nvim/lua/ace/plugins", alias = "nvim" },
            -- { path = "/home/acbailey/dotfiles/hypr/.config/hypr", alias = "hypr" },
            -- { path = "/home/acbailey/dotfiles/zsh/.zshrc", alias = "zsh" },
          },
          -- You may also add directories that will not be searched for subdirectories
          oneoff_directories = { "/home/acbailey/dotfiles/nvim" },
        },
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
    telescope.load_extension("whaler")
    telescope.load_extension("aerial")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local pickers = require("ace.telescopePickers")

    keymap.set("n", "<leader>fg", function()
      require("ace.telescopePickers").prettyFilesPicker({ picker = "git_files" })
    end, { desc = "Fuzzy find files if in git" })
    -- keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find files if in git" })
    -- keymap.set("n", "<leader>ff", function() require('ace.telescopePickers').prettyFilesPicker({ picker = 'find_files' }) end, { desc = "Fuzzy find files (non git)" })
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fl", function()
      require("ace.telescopePickers").prettyFilesPicker({ picker = "oldfiles" })
    end, { desc = "Fuzzy find recent file" })
    -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", function()
      require("ace.telescopePickers").prettyGrepPicker({ picker = "live_grep" })
    end, { desc = "Find string in cwd" })
    -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fS", function()
      require("ace.telescopePickers").prettyGrepPicker({ picker = "grep_string" })
    end, { desc = "Find string under cursor in cwd" })
    -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

    keymap.set("n", "<leader>fG", "<cmd>Telescope conflicts<cr>", { desc = "Search git conflicts" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Search registers" })
    keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Search jump list" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Search color schemes" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Telescope marks" })
    keymap.set("n", "<leader>fa", "<cmd>Telescope aerial<cr>", { desc = "Telescope aerial" })
    keymap.set(
      "n",
      "<leader>fo",
      "<cmd>Lazy load obsidian.nvim | ObsidianSearch<CR>",
      { desc = "Telescope Obsidian files" }
    )
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Search help tags" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Search keymaps" })
    keymap.set("n", "<leader>fb", function()
      pickers.prettyBuffersPicker()
    end)
    keymap.set("n", "<leader>fd", function()
      pickers.prettyDocumentSymbols()
    end)
    keymap.set("n", "<leader>ww", telescope.extensions.whaler.whaler)
    keymap.set("n", "<leader>wn", function()
      local w = telescope.extensions.whaler.whaler
      w({
        auto_file_explorer = true,
        auto_cwd = false,
        file_explorer_config = {
          plugin_name = "telescope",
          command = "Telescope find_files",
          prefix_dir = " cwd=",
        },
        theme = {
          previewer = false,
        },
      })
    end)
    keymap.set("n", "<leader>FS", function()
      pickers.prettyWorkspaceSymbols()
    end)
  end,
}
