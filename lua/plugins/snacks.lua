local function vcs_root()
  local root = LazyVim.root()
  local marker = vim.fs.find({ ".jj", ".git" }, { path = root, upward = true })[1]
  return marker and vim.fn.fnamemodify(marker, ":h") or root
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>jj",
        function()
          Snacks.terminal({ "lazyjj" }, {
            cwd = vcs_root(),
            win = {
              position = "float",
            },
          })
        end,
        desc = "LazyJJ (Root Dir)",
      },
    },
  },
}
