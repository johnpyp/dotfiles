" Plug: {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:polyglot_disabled = ['latex', 'markdown', 'go', 'vue']

call plug#begin('~/.local/share/nvim/plugged')

Plug 'AndrewRadev/tagalong.vim'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ajh17/Spacegray.vim'
Plug 'alaviss/nim.nvim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'chriskempson/base16-vim'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
" }}}
" General: {{{
let mapleader = " "
set fileencoding=UTF-8
set encoding=UTF-8
"set guifont=DroidSansMono\ Nerd\ Font\ 11
" theme
set background=dark
" let g:lightline = { 'colorscheme': 'darcula', }
set noshowmode
let g:gruvbox_italic = 1
let g:despacio_Twilight = 1
let g:spacegray_low_contrast = 1
let g:spacegray_underline_search = 1
let g:spacegray_use_italics = 1
colorscheme onedark
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" save swap every 100ms of no input
set updatetime=100
" Auto syntax from filetype + indents
syntax on
filetype plugin indent on
" indent width
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nostartofline
" tab -> space conversion
set expandtab
" show current line
set number
" show up/down relative line positions
" set relativenumber
" search case insensitive
set ignorecase
" Permanent Undo
set undodir=~/.vimdid
set undofile

set conceallevel=3
" coc helpful settings
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
let g:netrw_liststyle = 3
" set foldmethod
set foldmethod=marker

if !has('gui_running')
  set t_Co=256
endif
" italic comments
hi Comment cterm = italic
" cursor
set guicursor =n-v-c-sm:block,i-ci-ve:hor100-Cursor,r-cr-o:ver100
" highlight current line in insert
autocmd InsertEnter,InsertLeave * set cul!
" show tabline always
set showtabline=2
set regexpengine=0

set mouse=a
function! CloseOnLast()
    let cnt = 0

    for i in range(0, bufnr("$"))
        if buflisted(i)
            let cnt += 1
        endif
    endfor

    if cnt <= 1
        q
    else
        bw
    endif
 endfunction
command! BufOnly silent! execute "%bd|e#|bd#"
command! ProfileMe :profile start profile.log <bar> profile func * <bar> profile file *
command! ProfileStop :profile pause

function! SplitLineNicely()
    " Save previous value of last search register
    let saved_last_search_pattern = @/

    " :substitute replaces the content of the search register with the `\s\+`
    " pattern highlighting all whitespaces in the file
    substitute /\s\+/\r/g

    " Restore previous search register
    let @/ = saved_last_search_pattern
endfunction

" autocmd BufNewFile,BufRead *.ts set ft=javascript

let $FZF_DEFAULT_COMMAND = 'fd -t f""'
" }}}
" Vue: {{{
let g:vim_vue_plugin_use_pug = 1
let g:vim_vue_plugin_use_scss = 1
" }}}
" Fugitive: {{{
set statusline +=%{FugitiveStatusline()}
let g:fugitive_git_executable = 'hub'
" }}}
" Coc: {{{
let g:coc_node_path = 'node'
let g:coc_global_extensions = [
  \  "coc-cssmodules",
  \  "coc-css",
  \  "coc-emmet",
  \  "coc-eslint",
  \  "coc-explorer",
  \  "coc-flow",
  \  "coc-fsharp",
  \  "coc-go",
  \  "coc-highlight",
  \  "coc-html",
  \  "coc-java",
  \  "coc-json",
  \  "coc-lists",
  \  "coc-metals",
  \  "coc-omnisharp",
  \  "coc-prettier",
  \  "coc-python",
  \  "coc-r-lsp",
  \  "coc-rust-analyzer",
  \  "coc-snippets",
  \  "coc-svelte",
  \  "coc-svg",
  \  "coc-tailwindcss",
  \  "coc-texlab",
  \  "coc-tsserver",
  \  "coc-vimlsp",
  \  "coc-vetur",
  \  "coc-xml",
  \  "coc-yaml"
  \]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <CR> pumvisible()
                     \ ? "\<C-Y>"
                     \ : "<Plug>delimitMateCR"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for format selected region
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

let g:coc_explorer_global_presets = {
\   'cwd': {
\      'root-uri': 'getcwd()',
\   },
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

autocmd FileType json syntax match Comment +\/\/.\+$+
"}}}
" Ale: {{{
let g:ale_linters = {
  \   'crystal': 'all',
  \   'nix': 'all',
  \   'vim': 'all',
  \   'rust': [],
  \   'cpp': ['clang']
  \}
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'nix': ['nixpkgs-fmt'],
  \   'kotlin': [],
  \   'crystal': [{buffer -> {'command': 'crystal tool format %t', 'read_temporary_file': 1}}],
  \}

call ale#Set('crystal_ameba_executable', 'ameba')
let g:ale_linters_explicit = 1

let g:ale_sign_column_always = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_lint_on_text_changed = 1
let g:ale_fix_on_save = 1

let g:ale_kotlin_ktlint_exeutable = "ktlint"
"}}}
" Rooter: {{{
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_patterns = [".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", ".project", ".projectkeep"]
" }}}
" Airline: {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="bubblegum"
" }}}
" Emmet: {{{
let g:user_emmet_leader_key=','
let g:user_emmet_mode='n'    "only enable normal mode functions.
" }}}
" Go: {{{
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
" Tagalong: {{{
let g:tagalong_additional_filetypes = ['vue']
" }}}
" KEYBINDS: {{{

""" General:
" Set system clipboard keybindings
noremap <Leader>y "+y
noremap <Leader>p "+p
vmap y ygv<Esc>

" Navigate between buffers
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
imap <C-h> <ESC> :bp<CR>
imap <C-l> <ESC> :bn<CR>

" Quit buffer only
nnoremap <leader>q :bd<CR>

" Quit all buffers *except* this one
nnoremap <leader>Q :BufOnly<CR>

" Save without triggering anything, i.e save without autoformat
nnoremap <leader>W :noa w<CR>

" Edit and source init.vim
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" Clear selection
nnoremap <silent> <leader>e :nohl<CR>

" command! SplitLine :call SplitLineNicely()

" Visual navigation
nnoremap <silent> j gj
vnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> k gk

" Larger vertical jumps
nnoremap <silent> <C-k> 5k
nnoremap <silent> <C-j> 5j

""" Coc:
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

nmap <silent> <leader>ft <Plug>(coc-diagnostic-info)
nmap <silent> <leader>fd <Plug>(coc-definition)
nmap <silent> <leader>fD <Plug>(coc-type-definition)
nmap <silent> <leader>fi <Plug>(coc-implementation)
nmap <silent> <leader>fr <Plug>(coc-references)
nmap <silent> <leader>ff <Plug>(coc-fix-current)
nmap <silent> <leader>fo :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nnoremap <silent> <leader>fl  :<C-u>CocList diagnostics<cr>

xmap <silent> <leader>fa :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>fa :CocCommand actions.open<CR>

vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <silent> F :call CocAction('format')<CR>:ALEFix<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>


""" Ale:
nnoremap <silent> <leader>af :ALEFix<CR>
nnoremap <silent> <leader>ai :ALEInfo<CR>
nnoremap <silent> <leader>ah :ALEHover<CR>
nnoremap <silent> <leader>ad :ALEGoToDefinition<CR>
nnoremap <silent> <leader>ao :ALEOrganizeImports<CR>
nnoremap <silent> <leader>at :ALEDetail<CR>

""" Fugitive:
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

""" CocExplorer:
nmap <silent> <leader>n :execute "CocCommand explorer" getcwd()<CR>

""" FZF:
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
noremap <leader>s :Rg<space>

""" Windows:
map <leader>w <C-w>

" }}}
