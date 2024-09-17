return {
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("better_escape").setup({
        mapping = {
          i = {
            j = {
              k = function()
                -- Escape insert mode when jk is pressed
                if vim.bo.filetype == "lazy" then
                  -- <c-v> is used to avoid mappings
                  return "<c-v>j<c-v>k"
                end
                return "<esc>"
              end,
              j = function()
                -- Escape insert mode when jk is pressed
                if vim.bo.filetype == "lazy" then
                  -- <c-v> is used to avoid mappings
                  return "<c-v>j<c-v>j"
                end
                return "<esc>"
              end,
            },
          },
        }, -- a table with mappings to use
      })
    end,
  },
}
