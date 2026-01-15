local function find_config(bufnr, config_files)
  return vim.fs.find(config_files, {
    upward = true,
    stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]
end

--- Check if oxfmt is configured for a given buffer
---@param bufnr number
---@return boolean
local function has_oxfmt_config(bufnr)
  -- Check for oxfmt config files
  local oxfmt_config = find_config(bufnr, { ".oxfmtrc.json", "oxfmt.json" })
  if oxfmt_config then
    return true
  end

  -- Also check package.json for oxfmt reference
  local package_json = find_config(bufnr, { "package.json" })
  if package_json then
    local file = io.open(package_json, "r")
    if file then
      local content = file:read("*a")
      file:close()
      if content:find('"oxfmt"') then
        return true
      end
    end
  end

  return false
end

--- Dynamic formatter selection: oxfmt > biome > prettier
---@param bufnr number
---@return table
local function oxfmt_or_biome_or_prettier(bufnr)
  -- Priority 1: oxfmt (if configured)
  if has_oxfmt_config(bufnr) then
    return { "oxfmt", stop_after_first = true }
  end

  -- Priority 2: biome (if configured)
  local has_biome_config = find_config(bufnr, { "biome.json", "biome.jsonc" })
  if has_biome_config then
    return { "biome", stop_after_first = true }
  end

  -- Priority 3: prettier (if configured or as default)
  local has_prettier_config = find_config(bufnr, {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
  })
  if has_prettier_config then
    return { "prettier", stop_after_first = true }
  end

  -- Default to prettier if no config is found
  return { "prettier", stop_after_first = true }
end

-- Filetypes that support oxfmt (subset of prettier-compatible types)
-- See: https://oxc.rs/docs/guide/usage/formatter.html
local oxfmt_supported_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "css",
  "json",
  "jsonc",
}

-- Additional filetypes that use biome/prettier but not oxfmt
local biome_prettier_only_filetypes = {
  "scss",
  "less",
  "html",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        -- Custom oxfmt formatter definition with stdin support (oxfmt >= 0.18.0)
        -- See: https://github.com/oxc-project/oxc/pull/16868
        oxfmt = {
          command = "oxfmt",
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
          cwd = require("conform.util").root_file({
            ".oxfmtrc.json",
            "oxfmt.json",
            "package.json",
          }),
        },
      },
      formatters_by_ft = (function()
        local result = {}
        -- Filetypes that support oxfmt get the full priority chain
        for _, ft in ipairs(oxfmt_supported_filetypes) do
          result[ft] = oxfmt_or_biome_or_prettier
        end
        -- Filetypes that only support biome/prettier
        for _, ft in ipairs(biome_prettier_only_filetypes) do
          result[ft] = function(bufnr)
            local has_biome = find_config(bufnr, { "biome.json", "biome.jsonc" })
            if has_biome then
              return { "biome", stop_after_first = true }
            end
            return { "prettier", stop_after_first = true }
          end
        end
        return result
      end)(),
    },
  },
}
