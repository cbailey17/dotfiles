require("ace.remap")
require("ace.lazy_init")
require("ace.set")

require("ace.telescopePickers")

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

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

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | silent! checktime | endif",
	pattern = { "*" },
})

-- Set folded text color (background and foreground)
vim.api.nvim_set_hl(0, "Folded", { fg = "#2cf9ed", bg = "#2E3440", bold = true })

-- Set fold column color (background and foreground)
vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#2cf9ed", bg = "#3B4252" })

vim.api.nvim_create_augroup("LogSitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "LogSitter",
	pattern = "javascript,go,lua",
	callback = function()
		vim.keymap.set("n", "<leader>lc", function()
			require("logsitter").log()
		end)

		-- experimental visual mode
		vim.keymap.set("x", "<leader>lc", function()
			require("logsitter").log_visual()
		end)
	end,
})
