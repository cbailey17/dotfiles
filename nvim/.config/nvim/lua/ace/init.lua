require("ace.remap")
require("ace.lazy_init")
require("ace.set")

-- vim.api.nvim_set_hl(0, 'Comment', { fg="#", italic=true })

-- Run gofmt + goimports on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})
