return {
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local jdtls = require("jdtls")

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local extendedClientCapabilities = jdtls.extendedClientCapabilities

			local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" })
			local project_name = vim.fn.fnamemodify(root_dir, ":t")
			local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. project_name

			-- Set proper Java executable
			local java_cmd = "/home/acbailey/.sdkman/candidates/java/current/bin/java"

			-- Mason registry and language server path from mason
			local mason_registry = require("mason-registry")
			local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
			local java_agent = jdtls_path .. "/lombok.jar"

			-- run debug
			local function get_test_runner(test_name, debug)
				if debug then
					return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
				end
				return 'mvn test -Dtest="' .. test_name .. '"'
			end

			local function run_java_test_method(debug)
				local utils = require("ace.utils")
				local method_name = utils.get_current_full_method_name("\\#")
				vim.cmd("term " .. get_test_runner(method_name, debug))
			end

			local function run_java_test_class(debug)
				local utils = require("ace.utils")
				local class_name = utils.get_current_full_class_name()
				vim.cmd("term " .. get_test_runner(class_name, debug))
			end

			local function get_spring_boot_runner_gradle(profile, debug)
				local debug_param = ""
				if debug then
					debug_param =
						'-Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005"'
				end

				local profile_param = ""
				if profile then
					profile_param = "-Dspring-boot.run.profiles=" .. profile
				end

				return string.format("./gradlew bootRun %s %s", profile_param, debug_param)
			end

			local function get_spring_boot_runner(profile, debug)
				local debug_param = ""
				if debug then
					debug_param =
						' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
				end

				local profile_param = ""
				if profile then
					profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
				end

				return "mvn spring-boot:run " .. profile_param .. debug_param
			end

			local function run_spring_boot(debug)
				vim.cmd("tabnew | term " .. get_spring_boot_runner(nil, debug))
			end

			local function run_spring_boot_gradle(debug)
				vim.cmd("tabnew | term " .. get_spring_boot_runner_gradle(nil, debug))
			end

			-- Get debugging and testing packages ready
			local bundles = {
				vim.fn.glob(
					mason_registry.get_package("java-debug-adapter"):get_install_path()
						.. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
				),
			}
			-- Testing
			vim.list_extend(
				bundles,
				vim.split(
					vim.fn.glob(mason_registry.get_package("java-test"):get_install_path() .. "/extension/server/*.jar"),
					"\n"
				)
			)

			-- Main configuration table
			local config = {
				cmd = {
					java_cmd,

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
					"-javaagent:" .. java_agent,

					"-jar",
					vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

					"-configuration",
					jdtls_path .. "/config_linux",

					"-data",
					workspace_dir,
				},

				flags = {
					-- debounce_text_changes = 150,
					allow_incremental_sync = true,
				},

				settings = {
					java = {
						format = {
							-- settings = {
							-- -- Use Google Java style guidelines for formatting
							-- -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
							-- -- and place it in the ~/.local/share/eclipse directory
							-- url = "/.local/share/eclipse/eclipse-java-google-style.xml",
							-- profile = "GoogleStyle",
							-- },
						},
						-- jdt = {
						-- ls = {
						-- vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
						-- }
						-- },
						eclipse = {
							downloadSources = true,
						},
						configuration = {
							updateBuildConfiguration = "interactive",
							runtimes = {
								{
									name = "JavaSE-21",
									path = "/Users/alex.bailey/.sdkman/candidates/java/21.0.7-amzn",
								},
							},
						},
						signatureHelp = {
							enabled = true,
						},
						extendedClientCapabilities = extendedClientCapabilities,
						maven = {
							downloadSources = true,
						},
						implementationsCodeLens = {
							enabled = true,
						},
						referencesCodeLens = {
							enabled = true,
						},
						references = {
							includeDecompiledSources = true,
						},
						inlayHints = {
							parameterNames = {
								enabled = "all", -- literals, all, none
							},
						},
						saveActions = {
							organizeImports = true,
						},
						contentProvider = { preferred = "fernflower" },
						completion = {
							maxResults = 20,
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.hamcrest.CoreMatchers.*",
								"org.junit.jupiter.api.Assertions.*",
								"java.util.Objects.requireNonNull",
								"java.util.Objects.requireNonNullElse",
								"org.mockito.Mockito.*",
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
						codeGeneration = {
							toString = {
								template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
							},
							useBlocks = true,
						},
					},
				},

				init_options = {
					bundles = bundles,
				},
				capabilities = capabilities,

				on_attach = function(client, bufnr)
					-- handlers.on_attach(client, bufnr)
					if client.name == "jdtls" then
						local map = function(mode, lhs, rhs, desc)
							if desc then
								desc = desc
							end

							vim.keymap.set(
								mode,
								lhs,
								rhs,
								{ silent = true, desc = desc, buffer = bufnr, noremap = true }
							)
						end

						vim.keymap.set("n", "<leader>tm", function()
							run_java_test_method()
						end)
						vim.keymap.set("n", "<leader>TM", function()
							run_java_test_method(true)
						end)
						vim.keymap.set("n", "<leader>tc", function()
							run_java_test_class()
						end)
						vim.keymap.set("n", "<leader>TC", function()
							run_java_test_class(true)
						end)

						vim.keymap.set("n", "<leader>mp", function()
							run_spring_boot()
						end, { desc = "Run Maven project" })
						vim.keymap.set("n", "<leader>md", function()
							run_spring_boot(true)
						end, { desc = "Debug Maven project" })

						vim.keymap.set("n", "<leader>gp", function()
							run_spring_boot_gradle()
						end, { desc = "Run Gradle Spring Boot app" })

						vim.keymap.set("n", "<leader>gd", function()
							run_spring_boot_gradle(true)
						end, { desc = "Debug Gradle Spring Boot app" })

						map("n", "<leader>Co", jdtls.organize_imports, "Organize Imports")
						map("n", "<leader>Cv", jdtls.extract_variable, "Extract Variable")
						map("n", "<leader>Cc", jdtls.extract_constant, "Extract Constant")
						map("n", "<leader>Ct", jdtls.test_nearest_method, "Test Method")
						map("n", "<leader>CT", jdtls.test_class, "Test Class")
						map("n", "<leader>Cu", "<Cmd>JdtUpdateConfig<CR>", "Update Config")
						map(
							"v",
							"<leader>Cm",
							"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
							"Extract Method"
						)

						---@diagnostic disable-next-line: missing-fields
						jdtls.setup_dap({ hotcodereplace = "auto" })
						-- Auto-detect main and setup dap config
						require("jdtls.dap").setup_dap_main_class_configs({
							config_overrides = {
								vmArgs = "-Dspring.profiles.active=local",
							},
						})
					end
				end,
			}
			jdtls.start_or_attach(config)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					local attached = false
					for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if client.name == "jdtls" then
							attached = true
							break
						end
					end

					if not attached then
						require("jdtls").start_or_attach(config)
					end
				end,
			})
		end,
	},
}
