return {
	{
		"JavaHello/spring-boot.nvim",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
			-- "ibhagwan/fzf-lua",
		},
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = "/home/acbailey/java/" .. project_name
			local config = {
				cmd = {
					"java",

					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",

					"-jar",
					vim.fn.expand(
						"~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar"
					),

					"-configuration",
					vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_linux"),

					"-data",
					workspace_dir,
				},

				root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

				settings = {
					java = {},
				},

				init_options = {
					bundles = {
						vim.fn.glob(
							"/home/acbailey/projects/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.52.0.jar",
							1
						),
					},
				},
				capabilities = capabilities,
			}

			config["on_attach"] = function(client, bufnr)
				require("jdtls").setup_dap({ hotcodereplace = "auto" })
				require("jdtls.dap").setup_dap_main_class_configs()
			end
			require("jdtls").start_or_attach(config)
		end,
	},
}
