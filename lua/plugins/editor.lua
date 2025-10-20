return {
  { "tpope/vim-abolish" },

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

  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function()
  --     require("hardtime").setup({
  --       disabled_filetypes = {
  --         "qf",
  --         "netrw",
  --         "NvimTree",
  --         "lazy",
  --         "mason",
  --         "neo-tree",
  --         "neo-tree-popup",
  --         "notify",
  --         "DressingInput",
  --       },
  --     })
  --   end,
  -- },

  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
  {
    "vuki656/package-info.nvim",
    keys = {
      {
        "<leader>Ps",
        function()
          require("package-info").show()
        end,
        desc = "Show package info",
        mode = "n",
      },
      {
        "<leader>Pc",
        function()
          require("package-info").hide()
        end,
        desc = "Hide package info",
        mode = "n",
      },
      {
        "<leader>Pt",
        function()
          require("package-info").toggle()
        end,
        desc = "Toggle package info",
        mode = "n",
      },
      {
        "<leader>Pu",
        function()
          require("package-info").update()
        end,
        desc = "Update package version",
        mode = "n",
      },
      {
        "<leader>Pd",
        function()
          require("package-info").delete()
        end,
        desc = "Delete package",
        mode = "n",
      },
      {
        "<leader>Pi",
        function()
          require("package-info").install()
        end,
        desc = "Install package",
        mode = "n",
      },
      {
        "<leader>Pp",
        function()
          require("package-info").change_version()
        end,
        desc = "Change package version",
        mode = "n",
      },
    },
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup()
    end,
  },
}
