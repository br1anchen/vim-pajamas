return {
  {
    "aaronhallaert/advanced-git-search.nvim",
    keys = {
      {
        "<leader>gbf",
        function()
          require("telescope").extensions.advanced_git_search.diff_branch_file()
        end,
        desc = "Find diff for current file in branches",
      },
      {
        "<leader>gl",
        function()
          require("telescope").extensions.advanced_git_search.diff_commit_line()
        end,
        desc = "Find commit by selected lines",
      },
      {
        "<leader>gcf",
        function()
          require("telescope").extensions.advanced_git_search.diff_commit_file()
        end,
        desc = "Find commit by current file",
      },
    },
    config = function()
      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
    },
  },
}
