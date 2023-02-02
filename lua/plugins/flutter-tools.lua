return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "akinsho/flutter-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = "dart",
        event = "BufRead pubspec.yaml",
        init = function()
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
        end,
      },
    },
    opts = {
      servers = {
        dartls = {},
      },
    },
    setup = {
      dartls = function(_, opts)
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
          lsp = opts,
        })
        require("telescope").load_extension("flutter")
        return true
      end,
    },
  },
}
