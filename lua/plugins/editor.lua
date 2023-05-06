return {
  { "tpope/vim-abolish" },

  {
    "echasnovski/mini.surround",
    enabled = false,
  },

  {
    "folke/noice.nvim",
    opts = {
      messages = {
        enabled = true,
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
        view_history = "messages",
        view_search = "virtualtext",
      },
      notify = {
        enabled = true,
        view = "mini",
      },
    },
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

  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      {
        "<A-<>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "resize_left",
      },
      {
        "<A-+>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "resize_down",
      },
      {
        "<A-->",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "resize_up",
      },
      {
        "<A->>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "resize_right",
      },
      -- moving between splits
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "move_cursor_left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "move_cursor_down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "move_cursor_up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "move_cursor_right",
      },
      -- swapping buffers between windows
      {
        "<leader><leader>h",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "swap_buf_left",
      },
      {
        "<leader><leader>j",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "swap_buf_down",
      },
      {
        "<leader><leader>k",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "swap_buf_up",
      },
      {
        "<leader><leader>l",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "swap_buf_right",
      },
    },
  },
}
