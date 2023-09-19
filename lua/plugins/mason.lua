return {
  { "mfussenegger/nvim-dap" },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint_d",
        "prettier",
        "prettierd",
        "luacheck",
        "stylua",
        "shellcheck",
        "shfmt",
        "stylelint",
        "black",
        "sqlfluff",
        "xmlformatter",
        "dart-debug-adapter",
        "codelldb",
      },
    },
  },
}
