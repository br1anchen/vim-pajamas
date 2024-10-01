return {
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup({
        hint = "floating-big-letter",
      })
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
