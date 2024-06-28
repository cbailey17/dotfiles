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
        require('sidebar-nvim').setup({
            open = false,
            sections = {
                -- harpoon_files_section,
                'git',
                'buffers',
                'todos',
                'files',
            },
        })
    end
}

