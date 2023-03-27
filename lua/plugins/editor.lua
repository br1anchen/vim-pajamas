return {
  { "tpope/vim-abolish" },

  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "rhysd/git-messenger.vim",
    config = function()
      require("which-key").register({
        g = {
          m = { "<cmd>GitMessenger<cr>", "git messenger" },
        },
      }, { prefix = "<leader>", mode = "n" })
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "*",
        dart = { AARRGGBB = true },
      },
      user_default_options = {
        tailwind = true,
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
}
