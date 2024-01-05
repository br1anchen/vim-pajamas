return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "astro",
        "bashls",
        "biome",
        "eslint",
        "html",
        "jsonls",
        "lemminx",
        "marksman",
        "prismals",
        "pyright",
        "rnix",
        "rust_analyzer",
        "sqlls",
        "stylelint_lsp",
        "lua_ls",
        "tailwindcss",
        "taplo",
        "texlab",
        "tsserver",
        "yamlls",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb",
        "biome",
        "dart-debug-adapter",
        "eslint_d",
        "luacheck",
        "prettier",
        "prettierd",
        "ruff",
        "shellcheck",
        "shfmt",
        "sqlfluff",
        "stylelint",
        "stylua",
        "xmlformatter",
      },
    },
  },
}
