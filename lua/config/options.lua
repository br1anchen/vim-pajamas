-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.winbar = "%=%m %f"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.lazyvim_prettier_needs_config = false

-- Use tsgo as TypeScript LSP (instead of default vtsls)
vim.g.lazyvim_ts_lsp = "tsgo"

-- Enable auto-format on save
vim.g.autoformat = true
