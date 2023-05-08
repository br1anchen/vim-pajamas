local function neotest()
  return require("neotest")
end
local function open()
  neotest().output.open({ enter = true, short = false })
end
local function run_file()
  neotest().run.run(vim.fn.expand("%"))
end
local function run_file_sync()
  neotest().run.run({ vim.fn.expand("%"), concurrent = false })
end
local function nearest()
  neotest().run.run()
end
local function next_failed()
  neotest().jump.prev({ status = "failed" })
end
local function prev_failed()
  neotest().jump.next({ status = "failed" })
end
local function toggle_summary()
  neotest().summary.toggle()
end
local function cancel()
  neotest().run.stop({ interactive = true })
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    { "rcarriga/neotest-plenary", dependencies = { "nvim-lua/plenary.nvim" } },
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust",
    "sidlatau/neotest-dart",
  },
  keys = {
    { "<localleader>ts", toggle_summary, desc = "neotest: toggle summary" },
    { "<localleader>to", open, desc = "neotest: output" },
    { "<localleader>tn", nearest, desc = "neotest: run" },
    { "<localleader>tf", run_file, desc = "neotest: run file" },
    { "<localleader>tF", run_file_sync, desc = "neotest: run file synchronously" },
    { "<localleader>tc", cancel, desc = "neotest: cancel" },
    { "[n", next_failed, desc = "jump to next failed test" },
    { "]n", prev_failed, desc = "jump to previous failed test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rust"),
        require("neotest-dart")({
          command = "flutter", -- Command being used to run tests. Defaults to `flutter`
          -- Change it to `fvm flutter` if using FVM
          -- change it to `dart` for Dart only tests
          use_lsp = true, -- When set Flutter outline information is used when constructing test name.
        }),
      },
    })
  end,
}
