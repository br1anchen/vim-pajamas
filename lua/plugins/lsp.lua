local lsputil = require("lspconfig.util")

---Specialized root pattern that allows for an exclusion
---@param opt { root: string[], exclude: string[] }
---@return fun(file_name: string): string | nil
local function root_pattern_exclude(opt)
  return function(fname)
    local excluded_root = opt.exclude and lsputil.root_pattern(unpack(opt.exclude))(fname) or nil
    local included_root = lsputil.root_pattern(unpack(opt.root))(fname)

    if excluded_root then
      return nil
    else
      return included_root
    end
  end
end

--- Check if oxlint is configured for a given file path
---@param fname string
---@return boolean
local function has_oxlint_config(fname)
  local path = vim.fn.fnamemodify(fname, ":p:h")

  -- Check for .oxlintrc.json
  local oxlintrc = vim.fs.find(".oxlintrc.json", { path = path, upward = true, type = "file" })[1]
  if oxlintrc then
    return true
  end

  -- Check for package.json with oxlint reference
  local package_jsons = vim.fs.find("package.json", { path = path, upward = true, type = "file", limit = math.huge })
  for _, pj in ipairs(package_jsons) do
    local file = io.open(pj, "r")
    if file then
      local content = file:read("*a")
      file:close()
      if content:find('"oxlint"') or content:find('"oxc"') or content:find("oxc_language_server") then
        return true
      end
    end
  end

  return false
end

--- Find the nearest oxlint config, preferring package-level over monorepo root.
--- In turborepo setups, this finds the closest .oxlintrc.json or package.json with oxlint field.
--- Compatible with both old lspconfig style (fname) and new Nvim 0.11 style (bufnr, on_dir).
---@param bufnr_or_fname number|string
---@param on_dir? fun(dir: string|nil)
---@return string|nil
local function find_oxlint_root(bufnr_or_fname, on_dir)
  -- Handle both old lspconfig style (fname string) and new Nvim 0.11 style (bufnr number)
  local fname
  if type(bufnr_or_fname) == "number" then
    fname = vim.api.nvim_buf_get_name(bufnr_or_fname)
  else
    fname = bufnr_or_fname
  end

  local path = vim.fn.fnamemodify(fname, ":p:h")

  -- Check if we're in a project that uses biome or deno (exclude oxlint)
  local excluded_markers = { "biome.json", "biome.jsonc", "deno.json", "deno.jsonc" }
  local excluded_root = vim.fs.find(excluded_markers, { path = path, upward = true, type = "file" })[1]
  if excluded_root then
    if on_dir then
      on_dir(nil)
    end
    return nil
  end

  local result = nil

  -- Priority 1: Look for .oxlintrc.json (explicit oxlint config)
  -- This finds the NEAREST config, so package-level takes precedence over monorepo root
  local oxlintrc = vim.fs.find(".oxlintrc.json", { path = path, upward = true, type = "file" })[1]
  if oxlintrc then
    result = vim.fs.dirname(oxlintrc)
  else
    -- Priority 2: Look for package.json that contains "oxlint" reference
    -- Iterate through all package.json files from nearest to furthest
    local package_jsons = vim.fs.find("package.json", { path = path, upward = true, type = "file", limit = math.huge })
    for _, pj in ipairs(package_jsons) do
      local file = io.open(pj, "r")
      if file then
        local content = file:read("*a")
        file:close()
        -- Check if package.json references oxlint (dependency, script, or config field)
        if content:find('"oxlint"') or content:find('"oxc"') or content:find("oxc_language_server") then
          result = vim.fs.dirname(pj)
          break
        end
      end
    end
  end

  -- Support new Nvim 0.11 callback style
  if on_dir then
    on_dir(result)
  end

  return result
end

--- Find eslint root, but exclude when oxlint is configured (oxlint takes priority)
--- Compatible with both old lspconfig style (fname) and new Nvim 0.11 style (bufnr, on_dir).
---@param bufnr_or_fname number|string
---@param on_dir? fun(dir: string|nil)
---@return string|nil
local function find_eslint_root(bufnr_or_fname, on_dir)
  local fname
  if type(bufnr_or_fname) == "number" then
    fname = vim.api.nvim_buf_get_name(bufnr_or_fname)
  else
    fname = bufnr_or_fname
  end

  local path = vim.fn.fnamemodify(fname, ":p:h")

  -- If oxlint is configured, don't attach eslint (oxlint takes priority)
  if has_oxlint_config(fname) then
    if on_dir then
      on_dir(nil)
    end
    return nil
  end

  -- Also exclude for biome/deno projects
  local excluded_markers = { "biome.json", "biome.jsonc", "deno.json", "deno.jsonc" }
  local excluded_root = vim.fs.find(excluded_markers, { path = path, upward = true, type = "file" })[1]
  if excluded_root then
    if on_dir then
      on_dir(nil)
    end
    return nil
  end

  -- Use standard eslint config detection
  local eslint_configs = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  }

  local eslint_config = vim.fs.find(eslint_configs, { path = path, upward = true, type = "file" })[1]
  local result = eslint_config and vim.fs.dirname(eslint_config) or nil

  if on_dir then
    on_dir(result)
  end

  return result
end

return {
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "kkoomen/vim-doge",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    opts = {
      servers = {
        sourcekit = {},
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        denols = {
          root_dir = root_pattern_exclude({
            root = { "deno.json", "deno.jsonc", "deno.lock" },
          }),
        },
        biome = {
          root_dir = root_pattern_exclude({
            root = { "biome.json", "biome.jsonc" },
          }),
        },
        oxlint = {
          -- Use oxlint --lsp instead of oxc_language_server for better node_modules resolution
          cmd = { "oxlint", "--lsp" },
          root_dir = find_oxlint_root,
          single_file_support = false,
          workspace_required = true,
          -- Enable pull diagnostics (oxlint uses textDocument/diagnostic)
          capabilities = {
            textDocument = {
              diagnostic = {
                dynamicRegistration = false,
              },
            },
          },
          -- Settings passed via workspace/configuration requests
          -- The oxlint LSP requests config for section "oxc_language_server"
          settings = {
            oxc_language_server = {
              run = "onType",
              configPath = vim.NIL, -- Use auto-detected .oxlintrc.json
              tsConfigPath = vim.NIL, -- Use auto-detected tsconfig.json
              -- Enable type-aware linting (requires tsconfig.json in project)
              -- See: https://oxc.rs/docs/guide/usage/linter/type-aware.html
              typeAware = true,
              unusedDisableDirectives = "allow",
              disableNestedConfig = false,
              fixKind = "safe_fix",
              flags = {},
            },
          },
          -- Handler for pull diagnostics if server supports it
          on_attach = function(client, bufnr)
            -- If the server supports pull diagnostics, enable them
            if client.server_capabilities.diagnosticProvider then
              vim.lsp.diagnostic.enable(true, { bufnr = bufnr })
            end
          end,
        },
        -- ESLint: only attach when oxlint is NOT configured (oxlint takes priority)
        eslint = {
          root_dir = find_eslint_root,
        },
      },
    },
  },
}
