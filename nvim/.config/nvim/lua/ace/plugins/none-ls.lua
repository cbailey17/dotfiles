return {
  "nvimtools/none-ls.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("NoneLsFormatting", {})

    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end

    require("null-ls").setup({
      sources = {
        -- python
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.black,

        -- lua
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.formatting.stylua,

        -- javascript and typescript
        null_ls.builtins.formatting.prettier,

        -- other
        null_ls.builtins.completion.spell,
      },
      on_attach = on_attach,
    })

    vim.keymap.set("n", ",fm", vim.lsp.buf.format, { desc = "Format file" })
  end,
}
