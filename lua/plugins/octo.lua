return {
  "pwntester/octo.nvim",
  keys = {
    { "<leader>o", desc = "+Octo" },
    { "<leader>op", desc = "+PR" },
    { "<leader>opc", "<cmd>Octo pr create<CR>", desc = "Create PR (Octo)" },
    { "<leader>opl", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
    { "<leader>opf", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
    { "<leader>opo", "<cmd>Octo pr reload<CR>", desc = "Reload PR (Octo)" },

    { "<leader>oi", desc = "+Issues" },
    { "<leader>oil", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
    { "<leader>oif", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },

    { "<leader>oR", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
    { "<leader>oF", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

    { "<leader>or", desc = "+Review" },
    { "<leader>ora", "<cmd>Octo review resume<CR>", desc = "Review resume (Octo)" },
    { "<leader>orc", "<cmd>Octo review commit<CR>", desc = "Review commits list (Octo)" },
    { "<leader>ord", "<cmd>Octo review discard<CR>", desc = "Review discard (Octo)" },
    { "<leader>ori", "<cmd>Octo review start<CR>", desc = "Review start (Octo)" },
    { "<leader>ors", "<cmd>Octo review submit<CR>", desc = "Review submit (Octo)" },
    { "<leader>orx", "<cmd>Octo review close<CR>", desc = "Review close (Octo)" },

    { "<leader>a", "", desc = "+assignee (Octo)", ft = "octo" },
    { "<leader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
    { "<leader>l", "", desc = "+label (Octo)", ft = "octo" },
    { "<leader>i", "", desc = "+issue (Octo)", ft = "octo" },
    { "<leader>r", "", desc = "+react (Octo)", ft = "octo" },
    { "<leader>p", "", desc = "+pr (Octo)", ft = "octo" },
    { "<leader>v", "", desc = "+review (Octo)", ft = "octo" },
    { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
    { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
  },
}
