return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
    config = function()
      local luasnip = require("luasnip")

      luasnip.filetype_extend("dart", { "flutter" })
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })

      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.luasnippets_path or "" })
      require("luasnip.loaders.from_vscode").lazy_load()

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

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
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      })

      opts.formatting = {
        format = function(entry, vim_item)
          if entry.source.name == "copilot" then
            vim_item.kind = "Copilot"
            vim_item.kind = string.format("%s %s", " ", "Copilot")
            vim_item.kind_hl_group = "CmpItemKindCopilot"
          else
            local icons = require("lazyvim.config").icons.kinds
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
          end

          return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
        end,
      }

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" }, { name = "copilot" } }))
    end,
  },
}
