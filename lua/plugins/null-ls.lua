return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    local b = nls.builtins

    -- JS html css stuff
    table.insert(opts.sources, b.formatting.prettier)
    table.insert(opts.sources, b.diagnostics.eslint)

    -- Lua
    table.insert(opts.sources, b.formatting.stylua)
    table.insert(opts.sources, b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }))

    -- Shell
    table.insert(opts.sources, b.formatting.shfmt)
    table.insert(opts.sources, b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }))

    -- Rust
    table.insert(opts.sources, b.formatting.rustfmt)

    -- CSS
    table.insert(opts.sources, b.diagnostics.stylelint)
    table.insert(opts.sources, b.formatting.stylelint)

    -- Dart
    table.insert(opts.sources, b.formatting.dart_format)

    -- Nix
    table.insert(opts.sources, b.formatting.nixfmt)
    table.insert(opts.sources, b.diagnostics.statix)

    -- Python
    table.insert(opts.sources, b.formatting.black)

    -- Swift/Obj-c
    -- b.formatting.swiftformat,
    table.insert(opts.sources, b.formatting.swift_format)

    -- SQL
    table.insert(
      opts.sources,
      b.formatting.sqlfluff.with({
        extra_args = { "--dialect", "mysql" }, -- change to your dialect
      })
    )
    table.insert(
      opts.sources,
      b.diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "mysql" }, -- change to your dialect
      })
    )
  end,
}
