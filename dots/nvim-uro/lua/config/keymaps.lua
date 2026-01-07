-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- :nohl with <leader>e
vim.keymap.set("n", "<leader>e", ":nohl<CR>", { desc = "Clear search highlights", silent = true })

-- Snacks delbuffer with <leader>q instead of bd
-- map("n", "<leader>bd", function()
--   Snacks.bufdelete()
vim.keymap.set("n", "<leader>q", function()
  Snacks.bufdelete()
end, { desc = "Delete buffer" })
vim.keymap.del("n", "<leader>qq")

-- <leader>p for fzf lua find files

vim.keymap.set("n", "<c-p>", LazyVim.pick("files", { root = false }), { desc = "Find Files (Cwd)" })
