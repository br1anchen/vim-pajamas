-- local Job = require("plenary.job")
--
-- ---Join path segments using the os separator
-- ---@vararg string
-- ---@return string
-- local function path_join(...)
--   local result = table.concat(vim.tbl_flatten({ ... }), "/"):gsub("/" .. "+", "/")
--   return result
-- end
--
-- local function _flutter_sdk_root(bin_path)
--   -- convert path/to/flutter/bin/flutter into path/to/flutter
--   return vim.fn.fnamemodify(bin_path, ":h:h")
-- end
--
-- local function _flutter_sdk_dart_bin(flutter_sdk)
--   -- retrieve the Dart binary from the Flutter SDK
--   local binary_name = "dart"
--   return path_join(flutter_sdk, "bin", binary_name)
-- end
--
-- local function get_default_binaries()
--   local flutter_bin = vim.fn.resolve(vim.fn.exepath("flutter"))
--   return {
--     flutter_bin = flutter_bin,
--     dart_bin = vim.fn.resolve(vim.fn.exepath("dart")),
--     flutter_sdk = _flutter_sdk_root(flutter_bin),
--   }
-- end
--
-- local function path_from_lookup_cmd(lookup_cmd)
--   local paths = {}
--   local parts = vim.split(lookup_cmd, " ")
--   local cmd = parts[1]
--   local args = vim.list_slice(parts, 2, #parts)
--
--   local job = Job:new({ command = cmd, args = args })
--   job:after_failure(vim.schedule_wrap(function()
--     print(string.format("Error running %s", lookup_cmd))
--   end))
--   job:after_success(vim.schedule_wrap(function(j, _)
--     local result = j:result()
--     local flutter_sdk_path = result[1]
--     if flutter_sdk_path then
--       paths.dart_bin = _flutter_sdk_dart_bin(flutter_sdk_path)
--       paths.flutter_bin = path_join(flutter_sdk_path, "bin", "flutter")
--       paths.flutter_sdk = flutter_sdk_path
--     else
--       paths = get_default_binaries()
--     end
--     return paths
--   end))
--   job:start()
-- end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      -- "sidlatau/neotest-dart",
      "marilari88/neotest-vitest",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last Test",
      },
    },
    opts = function(_, opts)
      table.insert(opts.adapters, require("neotest-vitest"))
      -- table.insert(
      --   opts.adapters,
      --   require("neotest-dart")({
      --     command = path_from_lookup_cmd("asdf where flutter"),
      --     use_lsp = true,
      --   })
      -- )

      table.insert(opts.output, { open_on_run = true })
      table.insert(opts.quickfix, {
        open = function()
          if require("lazyvim.util").has("trouble.nvim") then
            vim.cmd("Trouble quickfix")
          else
            vim.cmd("copen")
          end
        end,
      })
    end,
  },
}
