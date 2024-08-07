require("ace.remap")
require("ace.lazy_init")
require("ace.set")

require("ace.telescopePickers")

-- Run gofmt + goimports on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimports()
  end,
  group = format_sync_grp,
})

vim.api.nvim_create_augroup("bufcheck", { clear = true })
-- start terminal in insert mode-- start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
  group = "bufcheck",
  pattern = "*",
  command = "startinsert | set winfixheight",
})

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "bufcheck",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Linking highlight groups
vim.cmd([[hi link AerialClass Type]])
vim.cmd([[hi link AerialClassIcon Special]])

-- Customizing specific highlight groups
vim.cmd([[hi AerialFunctionIcon guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE]])

-- Fallback and special cases
vim.cmd([[hi link AerialNormal Normal]])
vim.cmd([[hi link AerialLine QuickFixLine]])

-- Additional customization
vim.cmd([[hi AerialLineNC guibg=Gray]])
vim.cmd([[hi link AerialGuide Comment]])
vim.cmd([[hi AerialGuide1 guifg=Red]])
vim.cmd([[hi AerialGuide2 guifg=Blue]])
vim.cmd([[hi AerialGuide2 guifg=Blue]])
