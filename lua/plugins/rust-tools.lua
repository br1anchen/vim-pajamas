return {

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "simrat39/rust-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {
      servers = {
        rust_analyzer = {},
      },
    },
    setup = {
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
        return true
      end,
    },
  },
}
