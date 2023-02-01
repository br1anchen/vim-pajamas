return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "css",
        "dart",
        "html",
        "java",
        "javascript",
        "json",
        "kotlin",
        "latex",
        "lua",
        "markdown",
        "nix",
        "python",
        "query",
        "rust",
        "swift",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint_d",
        "prettierd",
        "luacheck",
        "stylua",
        "shellcheck",
        "shfmt",
        "black",
        "sqlfluff",
        "xmlformatter",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
        bashls = {},
        html = {},
        jsonls = {},
        lemminx = {},
        marksman = {},
        prismals = {},
        pyright = {},
        rnix = {},
        rust_analyzer = {},
        sourcekit = {},
        sqls = {},
        stylelint_lsp = {},
        sumneko_lua = {},
        taplo = {},
        texlab = {},
        tsserver = {},
        yamlls = {},
      },
    },
  },

  { import = "lazyvim.plugins.extras.lang.typescript" },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      local b = nls.builtins
      return {
        sources = {
          -- JS html css stuff
          b.formatting.prettierd,
          b.diagnostics.eslint,

          -- Lua
          b.formatting.stylua,
          b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

          -- Shell
          b.formatting.shfmt,
          b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

          -- Rust
          b.formatting.rustfmt,

          -- CSS
          b.diagnostics.stylelint,
          b.formatting.stylelint,

          -- Dart
          b.formatting.dart_format,

          -- Nix
          b.formatting.nixfmt,
          b.diagnostics.statix,

          -- Python
          b.formatting.black,

          -- Swift/Obj-c
          b.formatting.swiftformat,

          -- XML

          -- SQL
          b.formatting.sqlfluff.with({
            extra_args = { "--dialect", "mysql" }, -- change to your dialect
          }),
          b.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "mysql" }, -- change to your dialect
          }),
        },
      }
    end,
  },
}
