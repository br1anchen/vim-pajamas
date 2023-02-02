return {
  { "mfussenegger/nvim-dap" },
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
        "dart-debug-adapter",
        "codelldb",
      },
    },
  },
}
