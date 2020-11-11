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
"Plug 'Raimondi/delimitMate'
Plug 'Shougo/echodoc.vim'
" Plug 'airblade/vim-gitgutter'
Plug 'pantharshit00/vim-prisma'
Plug 'airblade/vim-rooter'
Plug 'fatih/vim-go'
Plug 'ferrine/md-img-paste.vim'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
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
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'romgrk/barbar.nvim'
Plug 'romgrk/doom-one.vim'
" Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'kyazdani42/nvim-tree.lua'

call plug#end()
" }}}
" General: {{{
let mapleader = " "
set fileencoding=UTF-8
set encoding=UTF-8
set background=dark
set noshowmode

let g:nvcode_termcolors=256
set termguicolors
colorscheme doom-one
syntax on
set tabstop=2 softtabstop=0 shiftwidth=2 expandtab smarttab
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
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
autocmd FileType json syntax match Comment +\/\/.\+$+
command! ProfileMe :profile start profile.log <bar> profile func * <bar> profile file *
command! ProfileStop :profile pause
" }}}
" Keybinds: {{{
" copy/paste
noremap <Leader>y "+y
noremap <Leader>p "+p
vmap y ygv<Esc>

" buffers-as-tabs
" nnoremap <silent> <C-h> :bp<CR>
" nnoremap <silent> <C-l> :bn<CR>
" Re-order to previous/next

nnoremap <silent> H :BufferPrevious<CR>
nnoremap <silent> L :BufferNext<CR>

nnoremap <silent> <C-h> :BufferMovePrevious<CR>
nnoremap <silent> <C-l> :BufferMoveNext<CR>
inoremap <silent> <C-h> <ESC> :BufferMovePrevious<CR>
inoremap <silent> <C-l> <ESC> :BufferMoveNext<CR>

nnoremap <leader>q :BufferClose<CR>
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

" nnoremap <silent> <leader>n :LuaTreeToggle<CR>

" Fzf:
nnoremap <silent> <leader>s :Rg<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>l :Buffers<CR>

" Fugitive:
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

" Markdown:
nnoremap <silent> <leader>mc :call CompileMarkdownTerm()<CR>
nnoremap <silent> <leader>mo :call system(ZathuraPdf(expand("%:p")) . "&!")<CR>
nnoremap <silent> <leader>mp :call mkdp#util#toggle_preview()<CR>


map <leader>w <C-w>

"let delimitMate_quotes = "\" ' `"
"au FileType markdown let b:delimitMate_quotes = "\" ' ` $"
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

let loaded_netrwPlugin = 1

let g:csv_nomap_h = 1
let g:csv_nomap_l = 1


let bufferline = {}
let bufferline.animation = v:false
let bufferline.closable = v:false
let bufferline.maximum_padding = 2

let g:echodoc#enable_at_startup = 1
let g:netrw_liststyle = 3

let g:floaterm_autoclose = 1

let g:sleuth_automatic = 1

let g:fugitive_git_executable = 'hub'

let g:tagalong_additional_filetypes = ['vue']

let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_patterns = [".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", ".project", ".projectkeep"]

let g:airline_theme="bubblegum"
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right                                                           
" let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline                                                 
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $FZF_DEFAULT_COMMAND = 'fd -t f""'

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --ignore-case --line-buffered -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--no-preview']}
    call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lua
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" lua << EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"   },
" }
" EOF
" }}}
" Imports: {{{
set runtimepath^=/home/johnpyp/code/coc-prisma
source $HOME/.config/nvim/coc.vim
" }}}
