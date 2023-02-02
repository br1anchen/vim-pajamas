return {
  "pwntester/octo.nvim",
  after = "telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("octo").setup()

    require("which-key").register({
      o = {
        name = "+Octo",
        c = {
          name = "+Comment",
          a = {
            "<cmd>Octo comment add<cr>",
            "Add comment",
          },
          d = {
            "<cmd>Octo comment delete<cr>",
            "Delete comment",
          },
        },
        p = {
          name = "+Pull Request",
          c = { "<cmd>Octo pr create<cr>", "Octo pr create" },
          l = { "<cmd>Octo pr list<cr>", "Octo pr list" },
          m = { "<cmd>Octo pr merge rebase<cr>", "Octo pr merge rebase" },
          r = { "<cmd>Octo pr reload<cr>", "Octo pr reload" },
        },
        r = {
          name = "+Review",
          a = { "<cmd>Octo review resume<cr>", "Octo review resume" },
          c = { "<cmd>Octo review commit<cr>", "Octo review commits list" },
          d = { "<cmd>Octo review discard<cr>", "Octo review discard" },
          i = { "<cmd>Octo review start<cr>", "Octo review start" },
          s = { "<cmd>Octo review submit<cr>", "Octo review submit" },
          x = { "<cmd>Octo review close<cr>", "Octo review close" },
        },
        t = {
          name = "+Thread",
          r = { "<cmd>Octo thread resolve<cr>", "Octo thread resolve" },
          u = { "<cmd>Octo thread unresolve<cr>", "Octo thread unresolve" },
        },
      },
    }, { prefix = "<leader>", mode = "n" })
  end,
}
