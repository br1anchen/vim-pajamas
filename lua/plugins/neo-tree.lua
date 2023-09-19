return {
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    depends = {
      "s1n7ax/nvim-window-picker",
    },
    init = function() end,
    opts = {
      window = {
        position = "right",
      },
    },
  },
}
