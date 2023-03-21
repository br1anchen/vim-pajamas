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
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fa",
        function()
          require("telescope.builtin").find_files({ follow = true, no_ignore = true, hidden = true })
        end,
        desc = "Find all Files",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
    },
  },
}
