-- Setup leader as space
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true }) -- Map space to a no-op to prevent conflicts
vim.g.mapleader = " " -- Set global leader key
vim.g.maplocalleader = " " -- Set buffer-local leader key
