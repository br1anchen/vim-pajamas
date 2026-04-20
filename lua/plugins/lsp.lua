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
        -- Override inlay hints for tsgo (disable verbose hints)
        tsgo = {
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
        -- Override inlay hints for vtsls (disable verbose hints)
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
        -- Disable jsonls formatting when oxfmt is configured (let conform.nvim handle it)
        jsonls = {
          on_attach = function(client, bufnr)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname == "" then
              return
            end

            local path = vim.fs.dirname(bufname)
            local oxfmt_config = vim.fs.find({ ".oxfmtrc.json", "oxfmt.json" }, {
              upward = true,
              path = path,
            })[1]

            local has_oxfmt = oxfmt_config ~= nil
            if not has_oxfmt then
              local package_json = vim.fs.find("package.json", { upward = true, path = path })[1]
              if package_json then
                local file = io.open(package_json, "r")
                if file then
                  local content = file:read("*a")
                  file:close()
                  has_oxfmt = content:find('"oxfmt"') ~= nil
                end
              end
            end

            if has_oxfmt then
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end
          end,
        },
      },
    },
  },
}
