return {
  'stevearc/oil.nvim',
  opts = {},
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == '..' or name == '.git' or name == '.svn'
        end,
      }
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
   -- vim.keymap.set("n", "<C-l>", function() require("oil.actions").refresh() end, { desc = "Open parent directory" })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
