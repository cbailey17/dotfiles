return {
  "akinsho/bufferline.nvim",
  -- lazy = true,
  dependencies = { "kyazdani42/nvim-web-devicons" },
  version = "*",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs", -- set to "tabs" to only show tabpages instead
        numbers = "none",
        indicator = { icon = " ", style = "none" },
        buffer_close_icon = "󰅖",
        -- modified_icon = "●",
        modified_icon = " ",
        -- close_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return "(" .. count .. ")"
        end,
        color_icons = true,   -- whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin",
        enforce_regular_tabs = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
      highlights = {
        buffer_selected = {
          bold = true,
          italic = true,
        },
        numbers_selected = {
          bold = true,
          italic = false,
        },
        close_button_selected = {},
        diagnostic_selected = {
          bold = true,
          italic = false,
        },
        hint_selected = {
          bold = true,
          italic = false,
        },
        hint_diagnostic_selected = {
          bold = true,
          italic = false,
        },
        info_selected = {
          bold = true,
          italic = false,
        },
        info_diagnostic_selected = {
          bold = true,
          italic = false,
        },
        warning_selected = {
          bold = true,
          italic = false,
        },
        warning_diagnostic_selected = {
          bold = true,
          italic = false,
        },
        error_selected = {
          bold = true,
          italic = false,
        },
        error_diagnostic_selected = {
          bold = true,
          italic = false,
        },
        duplicate_selected = {},
        duplicate_visible = {},
        duplicate = {},
        pick_selected = {
          bold = true,
          italic = false,
        },
        pick_visible = {
          bold = true,
          italic = false,
        },
        pick = {
          bold = true,
          italic = false,
        },
      },
    })
  end,
}
