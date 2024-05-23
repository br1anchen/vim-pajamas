return {
  {
    "vuki656/package-info.nvim",
    event = { "BufRead package.json" },
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      {
        "<leader>ps",
        function()
          require("package-info").show({ force = true })
        end,
        desc = "Display Latest Package Version",
      },
      {
        "<leader>pd",
        function()
          require("package-info").delete()
        end,
        desc = "Delete Dependency",
      },
      {
        "<leader>pp",
        function()
          require("package-info").change_version()
        end,
        desc = "Install Different Version",
      },
      {
        "<leader>pp",
        function()
          require("package-info").install()
        end,
        desc = "Install New Dependency",
      },
    },
    config = function()
      require("package-info").setup()
    end,
  },

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
    "kkoomen/vim-doge",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    opts = {
      servers = {
        dartls = {},
        sourcekit = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
      setup = {
        dartls = function(_, opts)
          require("lazyvim.util").lsp.on_attach(function(client, buffer)
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
      },
    },
  },
}
