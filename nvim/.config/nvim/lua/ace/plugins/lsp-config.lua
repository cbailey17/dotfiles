return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			-- "nvim-tree/nvim-web-devicons", -- optional
			"echasnovski/mini.icons",
		},
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
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
					"tsserver",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
			"b0o/schemastore.nvim",
		},
		opts = {
			servers = {
				cssls = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayFunctionParameterTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				html = {},
				yamlls = {
					settings = {
						yaml = {},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								paramType = true,
							},
							-- doc = {
							-- 	privateName = { "^_" },
							-- },
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								-- enable = false,
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			-- require("spring_boot").init_lsp_commands()
			local keymap = vim.keymap.set
			require("lspconfig.ui.windows").default_options.border = "rounded"

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- a table with the LSPs and whether or not
			-- they're allowed to format buffers
			local servers_filters = {
				["html"] = false, -- we use prettier
				["tsserver"] = false, -- we use prettier
				["eslint"] = false, -- not for formatting
				["cssls"] = false, -- we use prettier
				["tailwindcss"] = true, -- shouldn't clash with prettier idk
				["ruff_lsp"] = true,
				["pyright"] = false,
				["rust_analyzer"] = true,
				["lua_ls"] = false, -- we use stylua
				["gopls"] = true,
				["bashls"] = false,
				-- ["shfmt"] = true,
			}

			lspconfig.emmet_ls.setup({
				-- on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {
					"css",
					"html",
					"javascript",
					"javascriptreact",
					"typescriptreact",
					"less",
					"sass",
					"scss",
				},
				init_options = {
					html = {
						options = {
							-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
							["bem.enabled"] = true,
						},
					},
				},
			})
			lspconfig.jsonls.setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
			lspconfig.sqls.setup({
				on_attach = function(client, bufnr)
					require("sqls").on_attach(client, bufnr)
				end,
			})

			local tailwind_attach = function(client, bufnr)
				-- other stuff --
				require("tailwindcss-colors").buf_attach(bufnr)
			end
			lspconfig.tailwindcss.setup({
				on_attach = tailwind_attach,
			})

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
				if client.name == "ruff_lsp" then
					client.server_capabilities.hoverProvider = false
				end
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- lsp_formatting(bufnr)
						end,
					})
				end

				local opts = { noremap = true, silent = true, buffer = bufnr }

				keymap("n", "K", vim.lsp.buf.hover, opts)
				keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)
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
				if server ~= "jdtls" then
					lspconfig[server].setup(opts)
				end
			end
		end,
	},
}
