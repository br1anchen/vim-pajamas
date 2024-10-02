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
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
    },
  },
}
