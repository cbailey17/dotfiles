---
id: Global Key Bindings
aliases:
  - Workflow
tags:
  - neovim
---
# Workflow

## Most used 
- dotfiles
    - .config/nvim
    - .tmux.conf
    - .zshrc
    - komorebi.json
    - .config/whkdrc
    - yasb
        - .yasb/styles.css
        - .yasb/config.yaml
    - .Wezterm.lua
    - .config/kitty
    - autohotkey
    - starship.toml

- Work project
- browser


## Vim TODOS
### Need:

### Nice to have:
- tmux browser attached
- wezterm keybindings to change opacity
- fix up windows on start
- vim notify

---

## Komorebi

## Chrome
- <F8> focus next input
- SHIFT + <F8> focus prev input

## windows
- SUPER + SHIFT + S = SNIPPING TOOL

## Youtube
- increase playback speed  CTRL + . 
- decrease playback speed CTRL + ,
- focus on player CTRL + down

## TMUX
leader = <C-b>
open split vertical = leader + |
open split horizontal = leader + -
close split = leader + x
open new browser attached to session = leader + B
open session manager = leader + O
navigate between panes = 
next window <C-n>
previous window <C-p>
last window = leader + a
tmux fzf = leader + F
tmux fzf url = leader + u

## Vim
- [ ] set ; to : in normal mode and vice versa

<leader> = " "
<leader>pr = run python file (n) 

<leader>wd = save file (n, v)
<leader>wq = save and quit (n, v)

## Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader>frl", "<cmd>Telescope registers<cr>", { desc = "Search registers" })
keymap.set("n", "<leader>fjl", "<cmd>Telescope jumplist<cr>", { desc = "Search jump list" })
keymap.set("n", "<leader>fcs", "<cmd>Telescope colorscheme<cr>", { desc = "Search color schemes" })

### Inside of telescope
mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = open_with_trouble,
          },
        },

## Harpoon 
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "hn", function() harpoon:list():next() end)
vim.keymap.set("n", "hp",function() harpoon:list():prev() end)
vim.keymap.set("n", [[hm]], ":Telescope harpoon marks<CR>")
<C-d> remove mark in telescope picker
<leader>ht = harpoon telescope no preview

## DAP 
vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
    require("dapui").eval(nil, { enter = true })
end)
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F6>", dap.restart)
vim.keymap.set("n", "<F7>", dap.close


## Alpha NVIM
dashboard.section.buttons.val = {
    dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
    dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
    dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
    dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
    dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
    dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
}

## Comment

### NORMAL mode
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

### VISUAL mode
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment

## Completions
 mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),

## LSP

keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gD", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

## None-ls

vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format file" })

## Undo tree
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

## Mongo

nnoremap <leader>dbl <cmd>lua require('mongo-nvim.telescope.pickers').database_picker()<cr>
nnoremap <leader>dbcl <cmd>lua require('mongo-nvim.telescope.pickers').collection_picker('examples')<cr>
nnoremap <leader>dbdl <cmd>lua require('mongo-nvim.telescope.pickers').document_picker('examples', 'movies')<cr>

## Neogen documentation

vim.api.nvim_set_keymap("n", "<Leader>nm", ":lua require('neogen').generate()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'file' })<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", {})

## Obsidian

 -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }

## Oil 

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<C-l>", function() require("oil.actions").refresh() end, { desc = "Open parent directory" })

## TMUX NAV

vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})

## TODO Comments 

keymap.set("n", "]t", function()
  todo_comments.jump_next()
end, { desc = "Next todo comment" })

keymap.set("n", "[t", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo comment" })


## Trouble 

{ "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
{ "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
{ "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
{ "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },


## Surround

The three "core" operations of add/delete/change can be done with the keymaps ys{motion}{char}, ds{char}, and cs{target}{replacement}, respectively. For the following examples, * will denote the cursor position:
- [x] 
    Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls


