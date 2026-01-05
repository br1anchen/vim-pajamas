local lspconfig = require("lspconfig")
---Specialized root pattern that allows for an exclusion
---@param opt { root: string[], exclude: string[] }
---@return fun(file_name: string): string | nil
local function root_pattern_exclude(opt)
  local lsputil = require("lspconfig.util")

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
          root_dir = root_pattern_exclude({
            root = { ".oxlintrc.json", "package.json", ".git" },
            exclude = { "biome.json", "biome.jsonc", "deno.json", "deno.jsonc" },
          }),
          settings = {
            typeAware = true,
          },
        },
      },
    },
  },
}
