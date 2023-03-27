return {
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-emoji" },
      { "zbirenbaum/copilot-cmp" },
      { "roobert/tailwindcss-colorizer-cmp.nvim" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      -- original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item)

        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },
}
