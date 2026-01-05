return {
  "NvChad/nvterm",
  keys = {
    {
      "<leader>ti",
      function()
        require("nvterm.terminal").toggle("float")
      end,
      mode = "t",
      desc = "toggle floating term",
    },
    {
      "<leader>th",
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      mode = "t",
      desc = "toggle horizontal term",
    },
    {
      "<leader>tv",
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
      mode = "t",
      desc = "toggle vertical term",
    },
    {
      "<leader>ti",
      function()
        require("nvterm.terminal").toggle("float")
      end,
      mode = "n",
      desc = "toggle floating term",
    },
    {
      "<leader>th",
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      mode = "n",
      desc = "toggle horizontal term",
    },
    {
      "<leader>tv",
      function()
        require("nvterm.terminal").toggle("vertical")
      end,
      mode = "n",
      desc = "toggle vertical term",
    },
  },
  config = function()
    require("nvterm").setup({
      terminals = {
        list = {},
        type_opts = {
          float = {
            relative = "editor",
            row = 0.1,
            col = 0.25,
            width = 0.5,
            height = 0.7,
            border = "single",
          },
          horizontal = { location = "rightbelow", split_ratio = 0.3 },
          vertical = { location = "rightbelow", split_ratio = 0.5 },
        },
      },
      behavior = {
        close_on_exit = true,
        auto_insert = true,
      },
      enable_new_mappings = true,
    })
  end,
}
