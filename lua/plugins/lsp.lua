return {
  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
    config = function()
      vim.cmd("let g:dart_html_in_string = v:true")
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "dart",
    event = "BufRead pubspec.yaml",
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
        bashls = {},
        dartls = {},
        eslint = {},
        html = {},
        jsonls = {},
        lemminx = {},
        marksman = {},
        prismals = {},
        pyright = {},
        rnix = {},
        rust_analyzer = {},
        sourcekit = {},
        sqlls = {},
        stylelint_lsp = {},
        lua_ls = {},
        tailwindcss = {},
        taplo = {},
        texlab = {},
        tsserver = {},
        yamlls = {},
      },
      setup = {
        dartls = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "dartls" then
              require("which-key").register({
                f = {
                  q = {
                    function()
                      require("telescope").extensions.flutter.commands()
                    end,
                    "Find Flutter Command",
                  },
                },
                F = {
                  name = "+Flutter/Dart",
                  x = {
                    "<cmd>FlutterRun<cr>",
                    "Run the current project",
                  },
                  d = {
                    "<cmd>FlutterDevices<cr>",
                    "Show connected devices",
                  },
                  e = {
                    "<cmd>FlutterEmulators<cr>",
                    "Show connected emulators",
                  },
                  r = {
                    "<cmd>FlutterReload<cr>",
                    "Reload the running project",
                  },
                  R = {
                    "<cmd>FlutterRestart<cr>",
                    "Restart the running project",
                  },
                  q = {
                    "<cmd>FlutterQuit<cr>",
                    "Ends a running session",
                  },
                  D = {
                    "<cmd>FlutterDetach<cr>",
                    "Detach a running session",
                  },
                  o = {
                    "<cmd>FlutterOutlineToggle<cr>",
                    "Toggle the outline window",
                  },
                  O = {
                    "<cmd>FlutterOutlineOpen<cr>",
                    "Open an outline window",
                  },
                  p = {
                    "<cmd>FlutterDevTools<cr>",
                    "Starts a Dart Dev Tools server",
                  },
                  P = {
                    "<cmd>FlutterCopyProfilerUrl<cr>",
                    "Copies the profiler url",
                  },
                  l = {
                    "<cmd>FlutterLspRestart<cr>",
                    "Restarts the dart language server",
                  },
                  s = {
                    "<cmd>FlutterSuper<cr>",
                    "Go to super class",
                  },
                  A = {
                    "<cmd>FlutterReanalyze<cr>",
                    "Forces LSP server reanalyze",
                  },
                },
              }, { buffer = buffer, prefix = "<leader>", mode = "n" })
            end
          end)

          require("flutter-tools").setup({
            decorations = {
              statusline = {
                app_version = true,
                device = true,
              },
            },
            flutter_lookup_cmd = "asdf where flutter",
            widget_guides = {
              enabled = true,
            },
            dev_log = {
              enabled = true,
              open_cmd = "10sp", -- command to use to open the log buffer
            },
            debugger = {
              enabled = true,
              run_via_dap = true,
              register_configurations = function(_)
                require("dap").configurations.dart = {}
                require("dap.ext.vscode").load_launchjs()
              end,
            },
            lsp = opts,
          })
          require("telescope").load_extension("flutter")
          return true
        end,
        rust_analyzer = function(_, opts)
          local path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/") or ""
          local codelldb_path = path .. "adapter/codelldb"
          local liblldb_path = path .. "lldb/lib/liblldb.so"

          local dap = {}
          if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
            dap = {
              adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            }
          else
            local msg = "Either codelldb or liblldb is not readable."
              .. "\n codelldb: "
              .. codelldb_path
              .. "\n liblldb: "
              .. liblldb_path
            vim.notify(msg, vim.log.levels.ERROR)
          end
          require("rust-tools").setup({
            server = vim.list_extend(opts, {
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = {
                    command = "clippy",
                  },
                },
              },
            }),
            dap = dap,
          })
          return true
        end,
        tsserver = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "tsserver" then
              vim.keymap.set(
                "n",
                "<leader>co",
                "TypescriptOrganizeImports",
                { buffer = buffer, desc = "Organize Imports" }
              )
              vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
            end
          end)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
}
