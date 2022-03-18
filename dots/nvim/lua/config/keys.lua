local util = require("util")
-- Manage config
util.nnoremap("<Leader>ve", ":e ~/.config/nvim/init.lua<CR>")
util.nnoremap("<leader>vs", ":source ~/.config/nvim/init.lua<CR>")

-- Close buffers
util.nnoremap("<Leader>q", ":bd<CR>")

-- Save without triggering autocommands
util.nnoremap("<Leader>W", ":noa w<CR>")

-- Easier window commands
util.nmap("<Leader>w", "<C-w>")

-- Better copy-paste
util.nnoremap("<Leader>y", '"+y')
util.vnoremap("<Leader>y", '"+y')
util.nnoremap("<Leader>p", '"+p')
util.vmap("y", "ygv<Esc>")

-- Easy switch buffer
util.nnoremap("L", ":bnext<CR>")
util.nnoremap("H", ":bprevious<CR>")

-- Toggle tree
util.nnoremap("<Leader>n", ":NvimTreeToggle<CR>")

-- Clear highlight
util.nnoremap("<Leader>e", ":nohl<CR>")

-- Files/grep
util.nnoremap("<C-p>", ":FzfLua files<CR>")
util.nnoremap("<C-i>", ":FzfLua live_grep_native<CR>")

-- Better indent
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")

-- Remap k/j to account for word wrap
util.nnoremap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
util.nnoremap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Lazygit
util.nnoremap("<Leader>gs", ":LazyGit<CR>")

util.nnoremap("K", ":lua _G.show_documentation()<CR>")
util.nnoremap("<Leader>l", "<cmd>TroubleToggle document_diagnostics<CR>")

_G.show_documentation = function()
	local filetype = vim.bo.filetype
	if vim.tbl_contains({ "vim", "help" }, filetype) then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.tbl_contains({ "man" }, filetype) then
		vim.cmd("Man " .. vim.fn.expand("<cword>"))
	elseif vim.fn.expand("%:t") == "Cargo.toml" then
		require("crates").show_popup()
	else
		vim.lsp.buf.hover()
	end
end
