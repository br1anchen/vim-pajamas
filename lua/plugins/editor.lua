return {
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
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "zbirenbaum/copilot-cmp",
    },

    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" }, { name = "copilot" } }))
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>tt", "<cmd> Neotree toggle<cr>", desc = "NeoTree" },
    },
  },

  {
    "br1anchen/git-worktree.nvim",
    branch = "brian/tmp/fix-97",
    after = "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local git_worktree = require("git-worktree")
      local Job = require("plenary.job")
      local luv = vim.loop

      local function exists(filename)
        local stat = luv.fs_stat(filename)
        return stat and stat.type or false
      end

      local function is_melos_project()
        return exists("melos.yaml")
      end

      git_worktree.on_tree_change(function(op, metadata)
        if (op == git_worktree.Operations.Create or op == git_worktree.Operations.Switch) and is_melos_project() then
          print('Melos project detected, running "melos bs"')
          local melos_bs_job = Job:new({
            command = "melos",
            args = { "bs" },
            cwd = metadata.path,
          })

          melos_bs_job:after_success(vim.schedule_wrap(function()
            print("Melos bootstrap success")
          end))

          melos_bs_job:after_failure(vim.schedule_wrap(function(j)
            print("Melos bootstrap failed: " .. j:stderr_result())
          end))

          melos_bs_job:start()
        end
      end)

      require("telescope").load_extension("git_worktree")
    end,
  },

  {
    "br1anchen/octo.nvim",
    after = "telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
}
