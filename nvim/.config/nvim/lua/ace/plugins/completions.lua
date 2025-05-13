return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"zbirenbaum/copilot-cmp",
			"onsails/lspkind.nvim", -- vs-code like pictograms
			"danymat/neogen",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()
			local lspkind = require("lspkind")
			local neogen = require("neogen")
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local c = ls.choice_node
			local d = ls.dynamic_node
			local events = require("luasnip.util.events")
			local extras = require("luasnip.extras")
			local rep = extras.rep

			local keymap = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
			keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
			keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
			keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

			ls.add_snippets("javascript", {
				s("log", {
					t("console.log('%c '"),
					i(1),
					t(
						": ', 'font-size: 24px; font-weight: bold; color: #e04f38; background: #59bec9; padding: 2px 4px; border-radius: 4px;',"
					),
					i(2),
					t(");"),
				}),

				s("td", {
					t("// TODO: "),
					i(1),
				}),

				s("rfc", {
					t("import React from 'react';"),
					t(""),
					t("const "),
					i(0),
					t(" = (props) => {"),
					i(2),
					t("return ();"),
					t("};"),
				}),
			})

			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
			end
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- configure lspkind for vs-code like pictograms in completion menu
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
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
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "tmux" },
					{ name = "copilot" },
					{ name = "codecompanion" },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
}
