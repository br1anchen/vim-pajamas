return {
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
        html = {},
        jsonls = {},
        lemminx = {},
        marksman = {},
        prismals = {},
        pyright = {},
        rnix = {},
        rust_analyzer = {},
        sourcekit = {},
        sqls = {},
        stylelint_lsp = {},
        sumneko_lua = {},
        taplo = {},
        texlab = {},
        tsserver = {},
        yamlls = {},
      },
      setup = {
        dartls = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "dartls" then
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
            lsp = opts,
          })
          require("telescope").load_extension("flutter")
          return true
        end,
        rust_analyzer = function(_, opts)
          require("rust-tools").setup({
            tools = {
              autoSetHints = true,
              executor = require("rust-tools/executors").termopen,
              runnables = {
                use_telescope = true,
              },
              inlay_hints = {
                show_parameter_hints = true,
                parameter_hints_prefix = "<- ",
                other_hints_prefix = "=> ",
                max_len_align = false,
                max_len_align_padding = 1,
                right_align = false,
                right_align_padding = 7,
              },
              hover_actions = {
                border = "single",
                auto_focus = false,
              },
            },
            server = vim.list_extend(opts, {
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = {
                    command = "clippy",
                  },
                  inlayHints = {
                    closureReturnTypeHints = true,
                    lifetimeElisionHints = {
                      useParameterNames = true,
                    },
                    reborrowHints = true,
                  },
                },
              },
            }),
          })
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
