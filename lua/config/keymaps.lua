-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.keymap.set("t", "<C-e>", termcodes("<C-\\><C-N>"), { desc = "escape terminal mode" })

vim.keymap.set({ "i", "v", "n", "s" }, "<C-w>", "<cmd>w<cr><esc>", { desc = "Save file" })

vim.keymap.set({ "v", "n", "s" }, "<leader>R", "<cmd>checktime<cr><esc>", { desc = "Reload" })

vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv=gv ", { desc = "Move selected line down" })
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv=gv ", { desc = "Move selected line down" })
