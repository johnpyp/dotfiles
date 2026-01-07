-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false

-- Set to "basedpyright" to use basedpyright instead of pyright.
-- Set to false or empty string to disable Python LSP (will be overridden in plugins/python.lua)
vim.g.lazyvim_python_lsp = false
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"
