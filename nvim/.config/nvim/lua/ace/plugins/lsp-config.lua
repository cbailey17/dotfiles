return {
 {
    "williamboman/mason.nvim",
    dependencies = {
      -- "j-hui/fidget.nvim",
    },
    config = function()
      -- require("fidget").setup({})
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "jdtls",
          "gopls",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local keymap = vim.keymap.set

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- a table with the LSPs and whether or not
      -- they're allowed to format buffers
      local servers_filters = {
        ["html"] = false,       -- we use prettier
        ["tsserver"] = false,   -- we use prettier
        ["eslint"] = false,     -- not for formatting
        ["cssls"] = false,      -- we use prettier
        ["tailwindcss"] = true, -- shouldn't clash with prettier idk
        ["ruff_lsp"] = true,
        ["pyright"] = false,
        ["rust_analyzer"] = true,
        ["lua_ls"] = false, -- we use stylua
        ["gopls"] = true,
      }

      lspconfig.gopls.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.ruff_lsp.setup({})

      -- IMPORTANT!
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = function(client)
            -- true if can format, false otherwise
            return servers_filters[client.name]
          end,
        })
      end

      -- lsp keymaps and auto formatting
      local on_attach = function(client, bufnr)
        if client.name == 'ruff_lsp' then
          client.server_capabilities.hoverProvider = false
        end
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              lsp_formatting(bufnr)
            end,
          })
        end

        local opts = { noremap = true, silent = true, buffer = bufnr }

        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        keymap("n", "gD", vim.lsp.buf.declaration, opts)
        keymap("n", "ge", "<cmd>Telescope diagnostics<CR>", opts)
        keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      end

      -- used to ensure hover displays with borders
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      -- used to enable autocompletion, assign for every lanuage sever
      local capabilities = cmp_nvim_lsp.default_capabilities()

      for server, _ in pairs(servers_filters) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
          handlers = handlers,
        }
        if server ~= 'jdtls' then
          lspconfig[server].setup(opts)
        end
      end
    end
  }
}
