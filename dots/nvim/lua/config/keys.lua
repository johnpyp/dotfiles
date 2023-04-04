local util = require("util")

if vim.env.TERM == "xterm-kitty" then
  vim.cmd([[autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif]])
  vim.cmd([[autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif]])
end

local nnoremap = function(keys, func, desc, opts)
  opts = vim.tbl_deep_extend("force", { noremap = true, desc = desc }, opts or {})

  vim.keymap.set("n", keys, func, opts)
end

local vnoremap = function(keys, func, desc, opts)
  opts = vim.tbl_deep_extend("force", { noremap = true, desc = desc }, opts or {})

  vim.keymap.set("v", keys, func, opts)
end

local vmap = function(keys, func, desc, opts)
  opts = vim.tbl_deep_extend("force", { desc = desc }, opts or {})

  vim.keymap.set("v", keys, func, opts)
end

-- Manage config
util.nnoremap("<Leader>ve", ":e ~/.config/nvim/init.lua<CR>")
util.nnoremap("<leader>vs", ":source ~/.config/nvim/init.lua<CR>")

nnoremap("<leader>ve", ":e ~/.config/nvim/init.lua<CR>", "Edit vim config")
nnoremap("<leader>vs", ":source ~/.config/nvim/init.lua<CR>", "Source vim config")
nnoremap("<leader>W", ":noa w<CR>", "Quiet save")

nnoremap("<leader>w", "<C-w>", "Window (C-w)")

nnoremap("<leader>y", '"+y', "System Copy")
vnoremap("<leader>y", '"+y', "System Copy")
nnoremap("<leader>p", '"+p', "System Paste")

nnoremap("<leader>fr", ":source %<CR>", "File Reload")

vmap("y", "ygv<Esc>")

nnoremap("L", ":bnext<CR>", "Next Buffer")
nnoremap("H", ":bprevious<CR>", "Previous Buffer")

nnoremap("<leader>n", ":NvimTreeToggle<CR>", "Toggle Tree", { silent = true })

nnoremap("<leader>e", ":nohl<CR>", "Clear highlight")

nnoremap("<C-p>", ":FzfLua files<CR>", "Find Files")
nnoremap("<TAB>", ":FzfLua live_grep_native<CR>", "Fzf Grep")
nnoremap("<C-i>", ":FzfLua live_grep_native<CR>", "Fzf Grep")

nnoremap("<leader>th", require("fzf-lua").help_tags, "Help Tags")
nnoremap("<leader>tf", require("fzf-lua").files, "Find Files")
nnoremap("<leader>tg", require("fzf-lua").live_grep_native, "Live Grep")
nnoremap("<leader>tc", require("fzf-lua").colorschemes, "Colorscheme")
nnoremap("<leader>tt", require("fzf-lua").filetypes, "Set Filetype")

vnoremap("<", "<gv", "Better indent left")
vnoremap(">", ">gv", "Better indent right")

nnoremap("k", "v:count == 0 ? 'gk' : 'k'", "Move up in wrapped lines", { expr = true })
nnoremap("j", "v:count == 0 ? 'gj' : 'j'", "Move down in wrapped lines", { expr = true })

nnoremap("<leader>gs", ":LazyGit<CR>", "Lazy Git")

nnoremap("<Leader>l", "<cmd>TroubleToggle document_diagnostics<CR>", "List Diagnostics")
nnoremap("<Leader>q", ":bd<CR>", "Quit Buffer")

local function show_documentation()
  local filetype = vim.bo.filetype
  -- if vim.tbl_contains({ "vim", "help" }, filetype) then
  --   vim.cmd("h " .. vim.fn.expand("<cword>"))
  if vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
    require("crates").show_popup()
  else
    vim.cmd("Lspsaga hover_doc")
  end
end

nnoremap("K", show_documentation, "Show Documentation", { silent = true })
