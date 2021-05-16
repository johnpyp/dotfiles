-- Plugins {{{ --
local execute = vim.api.nvim_command
local fn = vim.fn


local function bootstrap_packer(namespace)
  local packer_root = vim.fn.stdpath('data') .. '/packer/' .. namespace
  local install_path = packer_root .. '/pack/packer/start/packer.nvim'

  -- Tell vim to look at the root
  vim.o.packpath = packer_root

  -- Install
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
  end

  local conf = {
    package_root = packer_root .. '/pack',
    compile_path = packer_root .. '/packer_compiled.vim',
    profile = {
      enable = true,
      threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    }
  }

  return conf
end

local packer_conf = bootstrap_packer("custom-lua")

local packer = require('packer')

packer.startup{function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'folke/tokyonight.nvim'

  -- Misc
  use 'airblade/vim-rooter'
  use 'terrortylor/nvim-comment'
  use 'svermeulen/vimpeccable'
  use 'norcalli/nvim_utils'
  use 'windwp/nvim-autopairs'
  -- use 'famiu/nvim-reload'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'        -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-compe'           -- Autocompletion plugin
  use 'glepnir/lspsaga.nvim'
  use 'kabouzeid/nvim-lspinstall'

  -- Snippets
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- Tresitter
  use 'nvim-treesitter/nvim-treesitter'
  -- use 'windwp/nvim-ts-autotag'

  -- Tree
  use 'kyazdani42/nvim-tree.lua'

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- Start
  use 'mhinz/vim-startify'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Statusline & Tabline
  use 'akinsho/nvim-bufferline.lua'
  use 'hoob3rt/lualine.nvim'
  -- use 'jose-elias-alvarez/buftabline.nvim'
end, config = packer_conf}
-- }}} Plugins --
-- General {{{ --
require('nvim_utils')
-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
-- vim.cmd[[colorscheme onedark]]
vim.cmd[[colorscheme tokyonight]]

-- Use space as leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = " "

--Incremental live completion
vim.o.inccommand = "nosplit"

--Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd[[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Fold using standard comments
vim.o.foldmethod = 'marker'


-- }}} General --
-- Keybindings {{{ --

-- Manage config
vim.api.nvim_set_keymap('n', '<leader>ve', ':e ~/.config/nvim/init.lua<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>vs', ':source ~/.config/nvim/init.lua<CR>', {noremap = true, silent = true})


-- Close buffers
vim.api.nvim_set_keymap('n', '<Leader>q', ':bd<CR>', { noremap = true, silent = true})

-- Save without triggering autocmds
vim.api.nvim_set_keymap('n', '<Leader>W', ':noa w<CR>', { noremap = true, silent = true})

-- Better copy paste
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'y', 'ygv<Esc>', {silent = true})

-- Tab switch buffer
vim.api.nvim_set_keymap('n', 'L', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'H', ':bprevious<CR>', {noremap = true, silent = true})

-- Toggle tree
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- Clear highlights
vim.api.nvim_set_keymap('n', '<Leader>e', ':nohl<CR>', {noremap = true, silent = true})

-- Find files/text
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-i>', ':Telescope live_grep<CR>', {noremap = true, silent = true})

-- Better indents
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap=true, expr = true, silent = true})

-- Fugitive:
vim.api.nvim_set_keymap('n', '<Leader>gs', ':Git<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>gp', ':Git push<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>gb', ':Git blame<CR>', {noremap = true, silent = true})

-- Remap escape to leave terminal mode
vim.api.nvim_exec([[
  augroup Terminal
    autocmd!
    au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    au TermOpen * set nonu
  augroup end
]], false)

-- Lsp Bindings:

-- scroll down hover doc or scroll in definition preview
vim.cmd("nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- scroll up hover doc
vim.cmd("nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

local on_attach_bindings = function(client, bufnr)

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', ':Lspsaga hover_doc<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', ':Lspsaga signature_help<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', ':<C-u>Lspsaga range_code_action<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', ':Lspsaga rename<CR>', opts)

  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
end



-- }}} Keybindings --
-- Tree {{{ --
vim.g.nvim_tree_side = 'right' --left by default
vim.g.nvim_tree_width = 30 --30 by default
-- vim.g.nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] --empty by default
-- vim.g.nvim_tree_gitignore = 1 --0 by default
-- vim.g.nvim_tree_auto_open = 1 --0 by default, opens the tree when typing `vim $DIR` or `vim`
vim.g.nvim_tree_auto_close = 1 --0 by default, closes the tree when it's the last window
vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' } --empty by default, don't auto open tree on specific filetypes.
vim.g.nvim_tree_quit_on_open = 1 --0 by default, closes the tree when you open a file
vim.g.nvim_tree_follow = 1 --0 by default, this option allows the cursor to be updated when entering a buffer
-- vim.g.nvim_tree_indent_markers = 1 --0 by default, this option shows indent markers when folders are open
-- vim.g.nvim_tree_hide_dotfiles = 1 --0 by default, this option hides files and folders starting with a dot `.`
-- vim.g.nvim_tree_git_hl = 1 --0 by default, will enable file highlight for git attributes (can be used without the icons).
-- vim.g.nvim_tree_root_folder_modifier = ':~' --This is the default. See :help filename-modifiers for more options
-- vim.g.nvim_tree_tab_open = 1 --0 by default, will open the tree when entering a new tab and the tree was previously open
-- vim.g.nvim_tree_width_allow_resize  = 1 --0 by default, will not resize the tree when opening a file
-- vim.g.nvim_tree_disable_netrw = 0 --1 by default, disables netrw
-- vim.g.nvim_tree_hijack_netrw = 0 --1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
-- vim.g.nvim_tree_add_trailing = 1 --0 by default, append a trailing slash to folder names
-- vim.g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
-- vim.g.nvim_tree_lsp_diagnostics = 1 --0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
-- vim.g.nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ] -- List of filenames that gets highlighted with NvimTreeSpecialFile
-- vim.g.nvim_tree_show_icons = {
--     \ 'git': 1,
--     \ 'folders': 0,
--     \ 'files': 0,
--     \ }
--If 0, do not show the icons for one of 'git' 'folder' and 'files'
--1 by default, notice that if 'files' is 1, it will only display
--if nvim-web-devicons is installed and on your runtimepath

-- default will show icon by default if no icon is provided
-- default shows no icon by default
vim.g.nvim_tree_icons = {
  default =  '',
  symlink =  '',
  git =  {
    unstaged =  "✗",
    staged =  "✓",
    unmerged =  "",
    renamed =  "➜",
    untracked =  "★",
    deleted =  "",
    ignored =  "◌"
  },
  folder =  {
    default =  "",
    open =  "",
    empty =  "",
    empty_open =  "",
    symlink =  "",
    symlink_open =  "",
  },
  lsp =  {
    hint =  "",
    info =  "",
    warning =  "",
    error =  "",
  }
}


vim.g.nvim_tree_disable_keybindings = true

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  -- default mappings
  ["<CR>"]           = tree_cb("edit"),
  ["l"]              = tree_cb("edit"),
  ["<2-LeftMouse>"]  = tree_cb("edit"),
  ["<2-RightMouse>"] = tree_cb("cd"),
  ["<C-]>"]          = tree_cb("cd"),
  ["<C-v>"]          = tree_cb("vsplit"),
  ["<C-x>"]          = tree_cb("split"),
  ["<C-t>"]          = tree_cb("tabnew"),
  ["<"]              = tree_cb("prev_sibling"),
  [">"]              = tree_cb("next_sibling"),
  ["<BS>"]           = tree_cb("close_node"),
  ["h"]           = tree_cb("close_node"),
  ["<S-CR>"]         = tree_cb("close_node"),
  ["<Tab>"]          = tree_cb("preview"),
  ["I"]              = tree_cb("toggle_ignored"),
  ["."]              = tree_cb("toggle_dotfiles"),
  ["R"]              = tree_cb("refresh"),
  ["a"]              = tree_cb("create"),
  ["d"]              = tree_cb("remove"),
  ["r"]              = tree_cb("rename"),
  ["<C-r>"]          = tree_cb("full_rename"),
  ["x"]              = tree_cb("cut"),
  ["c"]              = tree_cb("copy"),
  ["p"]              = tree_cb("paste"),
  ["[c"]             = tree_cb("prev_git_item"),
  ["]c"]             = tree_cb("next_git_item"),
  ["u"]              = tree_cb("dir_up"),
  ["q"]              = tree_cb("close"),
}

-- nnoremap <C-n> :NvimTreeToggle<CR>
-- nnoremap <leader>r :NvimTreeRefresh<CR>
-- nnoremap <leader>n :NvimTreeFindFile<CR>
-- " NvimTreeOpen and NvimTreeClose are also available if you need them

-- set termguicolors " this variable must be enabled for colors to be applied properly

-- " a list of groups can be found at `:help nvim_tree_highlight`
-- highlight NvimTreeFolderIcon guibg=blue

-- }}} Keybindings --
-- LSP {{{ --

DATA_PATH = vim.fn.stdpath('data')

require('lspsaga').init_lsp_saga()

local nvim_lsp = require('lspconfig')

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end

local on_attach = function(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  documentHighlight(client, bufnr)
  on_attach_bindings(client, bufnr)

  local autocmds = {
	lsp = {
	  {"CursorHold", "*", "Lspsaga show_line_diagnostics"}
	},
  }
  
  nvim_create_augroups(autocmds)
end

-- nvim_lsp.tsserver.setup {
--     cmd = {DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server", "--stdio"},
--     filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--     on_attach = on_attach,
--     -- This makes sure tsserver is not used for formatting (I prefer prettier)
--     -- on_attach = require'lsp'.common_on_attach,
--     root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
--     settings = {documentFormatting = false},
--    -- handlers = {
--    --     ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--    --         virtual_text = O.tsserver.diagnostics.virtual_text,
--    --         signs = O.tsserver.diagnostics.signs,
--    --         underline = O.tsserver.diagnostics.underline,
--    --         update_in_insert = true
--    -- 
--    --     })
--    -- }
-- }

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{ on_attach=on_attach }
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true
    }
)

vim.fn.sign_define(
    "LspDiagnosticsSignError",
    {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignWarning",
    {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignHint",
    {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignInformation",
    {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    " ﬌  (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

-- Completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = false;
    calc = true;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = false;
    snippets_nvim = true;
    treesitter = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

-- }}} LSP --
-- Misc {{{ --
-- local reload = require('nvim-reload')

-- reload.modules_reload_external = { 'packer' }

require('nvim_comment').setup()

-- Tabline/Status line
require("bufferline").setup {}
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

local actions = require('telescope.actions')
-- Telescope 
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
	["<C-j>"] = actions.move_selection_next,
	["<C-k>"] = actions.move_selection_previous,
	["<esc>"] = actions.close,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  }
}

-- Rooter
vim.g.rooter_change_directory_for_non_project_files = 'current'
vim.g.rooter_resolve_links = true
vim.g.rooter_patterns = {".git", "_darcs", ".hg", ".bzr", ".svn", ".project", ".projectkeep"}

--Tree

-- }}} Misc --
