return {
  "stevearc/conform.nvim",
  opts = function()
    ---@class ConformOpts
    local opts = {
      -- LazyVim will use these options when formatting with the conform.nvim formatter
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      ---@type table<string, conform.FormatterUnit[]>
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        javascript = { { "prettierd", "prettier", "biome" } },
        typescript = { { "prettierd", "prettier", "biome" } },
        jsx = { { "prettierd", "prettier", "biome" } },
        tsx = { { "prettierd", "prettier", "biome" } },
        html = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier", "biome" } },
        jsonc = { { "prettierd", "prettier", "biome" } },
        yaml = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        css = { "stylelint" },
        scss = { "stylelint" },
        less = { "stylelint" },
        dart = { "dart_format" },
        rust = { "rustfmt" },
        nix = { "nixfmt" },
        python = { "ruff" },
        swift = { "swift_format" },
        kotlin = { "ktlint" },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
        biome = {
          condition = function(ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettier = {
          condition = function(ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.js",
              "prettier.config.js",
              ".prettierrc.mjs",
              "prettier.config.mjs",
              ".prettierrc.cjs",
              "prettier.config.cjs",
            }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettierd = {
          condition = function(ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.js",
              "prettier.config.js",
              ".prettierrc.mjs",
              "prettier.config.mjs",
              ".prettierrc.cjs",
              "prettier.config.cjs",
            }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    }
    return opts
  end,
}
