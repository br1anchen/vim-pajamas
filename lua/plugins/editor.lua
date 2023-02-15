return {
  { "tpope/vim-abolish" },

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
}
