return {
  -- {
  --   -- Spring boot plugin
  --   "JavaHello/spring-boot.nvim",
  --   ft = "java",
  --   dependencies = {
  --     "mfussenegger/nvim-jdtls",
  --     -- "ibhagwan/fzf-lua",
  --   },
  --   config = function()
  --     require("spring_boot").setup({})
  --   end,
  -- },
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

      -- Get workspace directory for each project based on name
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = "/home/acbailey/Developer/java" -- .. project_name

      -- Set proper Java executable
      local java_cmd = "/usr/lib/jvm/java-21-openjdk/bin/java"

      -- Mason registry and language server path from mason
      local mason_registry = require("mason-registry")
      local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
      local java_agent = jdtls_path .. "/lombok.jar"

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
      -- vim.list_extend(bundles, require("spring_boot").java_extensions())

      -- Main configuration table
      local config = {
        cmd = {
          java_cmd,
          -- "java",

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

        root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),

        settings = {
          java = {
            -- jdt = {
            --   ls = {
            --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
            --   }
            -- },
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                {
                  name = "JavaSE-11",
                  path = "/usr/lib/jvm/java-11-openjdk/",
                },
                {
                  name = "JavaSE-17",
                  path = "/usr/lib/jvm/java-17-openjdk/",
                },
                {
                  name = "JavaSE-21",
                  path = "/usr/lib/jvm/java-21-openjdk/",
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
            format = {
              enabled = false,
              -- settings = {
              --   profile = "asdf"
              -- }
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
            map("n", "<leader>Co", jdtls.organize_imports, "Organize Imports")
            map("n", "<leader>Cv", jdtls.extract_variable, "Extract Variable")
            map("n", "<leader>Cc", jdtls.extract_constant, "Extract Constant")
            map("n", "<leader>Ct", jdtls.test_nearest_method, "Test Method")
            map("n", "<leader>CT", jdtls.test_class, "Test Class")
            map("n", "<leader>Cu", "<Cmd>JdtUpdateConfig<CR>", "Update Config")
            map(
              "v",
              "<leader>Cv",
              "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
              "Extract Variable"
            )
            map(
              "v",
              "<leader>Cc",
              "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
              "Extract Constant"
            )
            map(
              "v",
              "<leader>Cm",
              "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
              "Extract Method"
            )

            require("which-key").register({
              ["<leader>de"] = { "<cmd>DapContinue<cr>", "[JDLTS] Show debug configurations" },
              ["<leader>ro"] = {
                "<cmd>lua require'jdtls'.organize_imports()<cr>",
                "[JDLTS] Organize imports",
              },
            })
            ---@diagnostic disable-next-line: missing-fields
            -- jdtls.setup_dap({ hotcodereplace = "auto" })
            -- -- Auto-detect main and setup dap config
            -- require("jdtls.dap").setup_dap_main_class_configs({
            --   config_overrides = {
            --     vmArgs = "-Dspring.profiles.active=local",
            --   },
            -- })
          end
        end,
      }
      jdtls.start_or_attach(config)
    end,
  },
}
