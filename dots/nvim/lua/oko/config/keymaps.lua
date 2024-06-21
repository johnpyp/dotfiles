-- *Global* keymaps that don't cleanly fit into a plugin configuration
-- Prefer plugin configuration over this file.
--

vim.keymap.set("n", "<leader>y", '"+y', { desc = "System Copy", silent = true }) -- System copy
vim.keymap.set("n", "<leader>p", '"+p', { desc = "System Paste", silent = true }) -- System paste
vim.keymap.set("n", "<leader>W", ":noa w<CR>", { desc = "Quiet save", silent = true }) -- Save without triggering events and stuff

vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window (C-w)", silent = true })

vim.keymap.set("v", "y", "ygv<Esc>", { silent = true }) -- Better `y` behavior in visual mode, I forget what it does

-- Defined in oko.plugins.bufferline instead
-- vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Next Buffer", silent = true }) -- Easy buffer nav
-- vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Previous Buffer", silent = true }) -- Easy buffer nav

vim.keymap.set("n", "<leader>e", ":nohl<CR>", { desc = "Clear highlight", silent = true }) -- Clear highlights across the buffer

vim.keymap.set("v", "<", "<gv", { desc = "Better indent left", silent = true }) -- Better indent left in visual mode
vim.keymap.set("v", ">", ">gv", { desc = "Better indent right", silent = true }) -- Better indent right in visual mode

vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Quit Buffer", silent = true }) -- Close just the buffer

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up in wrapped lines", expr = true, silent = true }) -- Incantation to make moving up in wrapped lines better
vim.keymap.set(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Move down in wrapped lines", expr = true, silent = true }
) -- Incantation to make moving down in wrapped lines better

-- TODO: Put in plugin configs

vim.keymap.set("n", "<leader>cc", ":Neoconf global<CR>", { desc = "Neoconf Global" }) -- Toggle neoconf
-- nnoremap("<Leader>l", "<cmd>TroubleToggle document_diagnostics<CR>", "List Diagnostics")
--
vim.keymap.set("n", "<leader>oli", ":LspInfo<CR>", { desc = "Open LspInfo" })
vim.keymap.set("n", "<leader>oll", ":LspLog<CR>", { desc = "Open LspLog" })
vim.keymap.set("n", "<leader>om", ":Mason<CR>", { desc = "Open Mason" })
vim.keymap.set("n", "<leader>of", ":ConformInfo<CR>", { desc = "Open ConformInfo (Format)" })
