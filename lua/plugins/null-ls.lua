return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    local b = nls.builtins
    return {
      sources = {
        -- JS html css stuff
        b.formatting.prettier,
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
        -- b.formatting.swiftformat,
        b.formatting.swift_format,

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
}
