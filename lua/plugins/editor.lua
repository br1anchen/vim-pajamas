return {
  { "tpope/vim-abolish" },

  {
    "echasnovski/mini.surround",
    enabled = false,
  },

  {
    "nvim-pack/nvim-spectre",
    keys = {
      {
        "<leader>rs",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Replace in current file (Spectre)",
      },
      {
        "<leader>rp",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
      {
        "<leader>rw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace current word (Spectre)",
      },
    },
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
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  {
    "rhysd/git-messenger.vim",
    keys = {
      {
        "<leader>gm",
        "<cmd>GitMessenger<cr>",
        desc = "git messenger",
        mode = "n",
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

  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("hardtime").setup({
        disabled_filetypes = {
          "qf",
          "netrw",
          "NvimTree",
          "lazy",
          "mason",
          "neo-tree",
          "neo-tree-popup",
          "notify",
          "DressingInput",
        },
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
  },
}
