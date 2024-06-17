vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true }) -- Map space to a no-op to prevent conflicts

vim.g.mapleader = " " -- Set global leader key
vim.g.maplocalleader = " " -- Set buffer-local leader key

vim.o.termguicolors = true -- True color (comes first)
vim.o.hlsearch = true -- Highlight a completed search
vim.o.incsearch = true -- Highlight a search incrementally as you type

vim.o.inccommand = "split" -- Show replacements in a preview window live

vim.o.tabstop = 2 -- Number of spaces that a <TAB> in a file counts for visually
vim.o.softtabstop = 2 -- Number of spaces used while tabbing (defaults to shiftwidth if not set)
vim.o.shiftwidth = 2 -- Size of an indent
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.smarttab = true

vim.wo.number = true -- Show absolute line number
vim.o.hidden = true -- Do not save when switching buffers
vim.o.mouse = "a" -- Enable mouse mode
vim.o.breakindent = true -- Wrapped lines continue visually indented
vim.o.showbreak = nil -- Add visual indent to wrapped lines
vim.o.linebreak = true

vim.o.ttyfast = true
vim.o.termsync = false

--Save undo history
vim.cmd([[set undofile]])

vim.o.ignorecase = true -- Ignore case generally for searches (overridden by smartcase)
vim.o.smartcase = true -- Don't ignore case if uppercase chars are used in a search
vim.o.showmode = false -- Don't show mode since we have a status line
vim.o.termsync = false

-- vim.opt.splitbelow = true -- Put new windows below current
-- vim.opt.splitright = true -- Put new windows right of current

vim.o.timeoutlen = 300
vim.o.updatetime = 150 -- Decrease the update time
vim.o.signcolumn = "yes" -- Always show sign column

vim.o.foldmethod = "marker" -- Fold using standard marker comments

vim.o.list = true -- Show some invisible characters (tabs...
vim.o.backup = false -- Don't make a backup before overwriting a file
vim.o.writebackup = false -- Don't make a backup while writing a file
vim.o.joinspaces = false -- Don't use two spaces to join a line that ends with punctuation

vim.o.conceallevel = 0 -- Don't conceal characters (e.g in markdown)

vim.g.cursorhold_updatetime = 100

vim.opt.foldenable = false
vim.opt.completeopt = { "menu", "menuone", "noselect" }
