return {
  "sidebar-nvim/sidebar.nvim",
  config = function()
    -- local function get_harpoon_files()
    --     local harpoon = require('harpoon')
    --     local file_list = {}
    --
    --     for i, mark in ipairs(harpoon.get_mark_config().marks) do
    --         if mark.filename then
    --             table.insert(file_list, string.format("%d. %s", i, mark.filename))
    --         end
    --     end
    --
    --     return file_list
    -- end
    --
    -- local harpoon_files_section = {
    --     title = "Harpooned",
    --     icon = '',
    --     draw = function()
    --         return { lines = get_harpoon_files() }
    --     end,
    -- }
    --
    require("sidebar-nvim").setup({
      disable_default_keybindings = 0,
      bindings = nil,
      open = false,
      side = "left",
      initial_width = 35,
      hide_statusline = false,
      update_interval = 1000,
      sections = { "datetime", "git", "diagnostics", "buffers" },
      section_separator = { "", "󰆥 ", "" },
      section_title_separator = { "" },
      containers = {
        attach_shell = "/bin/sh",
        show_all = true,
        interval = 5000,
      },
      datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
      todos = { ignored_paths = { "~" } },
    })
  end,
}
