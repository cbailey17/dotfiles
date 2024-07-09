vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

-- map save to leader wd to write docs
keymap.set({ "n", "v" }, "<leader>wd", ":w<CR>", { desc = "Write document" })
keymap.set({ "n", "v" }, "<leader>wq", ":wq<CR>", { desc = "Write and quit" })

-- Editor
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set({ "n", "v" }, ";", ":", opts)

-- Yank and paste into system clipboard
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set({ "n", "v" }, "<leader>p", [["+p]])

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Tab Management
keymap.set("n", "<leader>tc", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tt", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab

-- Buffer management
keymap.set("n", "<leader>bn", ":bn<cr>", { desc = "Go to next buffer" })
keymap.set("n", "<leader>bp", ":bp<cr>", { desc = "Go to previous buffer" })
keymap.set("n", "<leader>bx", ":bd<cr>", { desc = "Close current buffer" })

-- Undo tree
keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)

-- Code actions
-- Python -------------------------------------------------------------------------------------

-- Define a function to run the current Python file
local function run_current_python_file()
  local file = vim.fn.expand("%")
  vim.cmd("!python3 " .. file)
end

-- Set the keymap to run the current Python file
keymap.set("n", "<leader><leader>r", run_current_python_file, { noremap = true, silent = true })
