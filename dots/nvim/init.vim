" Plug: {{{
filetype plugin indent on
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:polyglot_disabled = ['latex', 'markdown', 'pandoc', 'go', 'vue']

call plug#begin('~/.local/share/nvim/plugged')
Plug 'AndrewRadev/tagalong.vim'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/echodoc.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'fatih/vim-go'
Plug 'ferrine/md-img-paste.vim'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'plasticboy/vim-markdown'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()
" }}}
" Sensible: {{{
let mapleader = " "
set fileencoding=UTF-8
set encoding=UTF-8
set background=dark
set noshowmode
set termguicolors
colorscheme onedark
syntax on
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab
set number
set ignorecase
set undofile
set conceallevel=0
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=150
set shortmess+=c
set signcolumn=yes
set showbreak=﬌
set linebreak
set foldmethod=marker
set showtabline=2
set mouse=a
highlight Comment cterm=italic gui=italic
set guicursor=
set guicursor=a:blinkon0-blinkoff0,n-v-c-sm:block,i-ci-ve:hor100-Cursor,r-cr-o:ver100
autocmd InsertEnter,InsertLeave * set cul!
autocmd FileType json syntax match Comment +\/\/.\+$+
" }}}
" Keybinds: {{{
" copy/paste
noremap <Leader>y "+y
noremap <Leader>p "+p
vmap y ygv<Esc>

" buffers-as-tabs
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
imap <C-h> <ESC> :bp<CR>
imap <C-l> <ESC> :bn<CR>

nnoremap <leader>q :bd<CR>
nnoremap <leader>W :noa w<CR>

" vimrc
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

nnoremap <leader>e :nohl<CR>

" visual navigation
nnoremap <silent> j gj
vnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> k gk

nnoremap <silent> <leader>n :LuaTreeToggle<CR>

" Fzf:
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader><leader> :Buffers<CR>
nnoremap <silent> <leader>s :RGFuzzy<CR>

" Fugitive:
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

" Markdown:
nnoremap <silent> <leader>ll :call CompileMarkdownTerm()<CR>
nnoremap <silent> <leader>op :call system(ZathuraPdf(expand("%:p")) . "&!")<CR>
nmap <C-m> <Plug>MarkdownPreviewToggle

map <leader>w <C-w>

let delimitMate_quotes = "\" ' `"
au FileType markdown let b:delimitMate_quotes = "\" ' ` $"
" }}}
" Lua Tree: {{{
let g:lua_tree_quit_on_open = 1
let g:lua_tree_side = 'right'
let g:lua_tree_width = 40 "30 by default
let g:lua_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:lua_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:lua_tree_indent_markers = 0 "0 by default, this option shows indent markers when folders are open
let g:lua_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:lua_tree_git_hl = 0 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:lua_tree_show_icons = {
            \ 'git': 1,
            \ 'folders': 1,
            \ 'files': 1,
            \}

let g:lua_tree_bindings = {
            \ 'edit':            ['<CR>', 'o'],
            \ 'edit_vsplit':     '<C-v>',
            \ 'edit_split':      '<C-x>',
            \ 'edit_tab':        '<C-t>',
            \ 'toggle_ignored':  'I',
            \ 'toggle_dotfiles': '.',
            \ 'refresh':         'R',
            \ 'preview':         '<Tab>',
            \ 'cd':              '<C-]>',
            \ 'create':          'a',
            \ 'remove':          'd',
            \ 'rename':          'r',
            \ 'cut':             'x',
            \ 'copy':            'c',
            \ 'paste':           'p',
            \ 'prev_git_item':   '[c',
            \ 'next_git_item':   ']c'
            \ }

" }}}
" Other Plugin Config: {{{
lua require'colorizer'.setup({ "*", }, { mode = 'foreground' })

let g:echodoc#enable_at_startup = 1
let g:netrw_liststyle = 3

let g:floaterm_autoclose = 1

let g:sleuth_automatic = 1

let g:fugitive_git_executable = 'hub'

let g:tagalong_additional_filetypes = ['vue']

let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_patterns = [".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", ".project", ".projectkeep"]

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="bubblegum"

"""""""""""""""""
""" Markdown:
"""""""""""""""""

let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

function! ZathuraPdf(file_raw)
    let file = fnamemodify(a:file_raw, ":p:r") . ".pdf"
    return 'zathura ' . file
endfunction

function! CompileMarkdownTerm()
    if (index(["markdown", "pandoc"], &filetype) >= 0)
        :FloatermNew "compile-md" "%"
    endif
endfunction

command! -nargs=0 CompileMarkdown :call CompileMarkdownTerm()

let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 1
let g:mkdp_open_to_the_world = 0
function! g:Open_browser(url)
    silent exec "!google-chrome-stable --app=" . a:url
endfunction
let g:mkdp_browserfunc = 'g:Open_browser'

"""""""""""""""""
""" Fzf:
"""""""""""""""""

let $FZF_DEFAULT_COMMAND = 'fd -t f""'

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --ignore-case --line-buffered -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RGFuzzy call RipgrepFzf(<q-args>, <bang>0)

"""""""""""""""""
""" Go:
"""""""""""""""""

let g:go_highlight_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_doc_keywordprg_enabled = 0

" }}}
" Imports: {{{
source $HOME/.config/nvim/coc.vim
" }}}
