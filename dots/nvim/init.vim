" Plug: {{{
call plug#begin('~/.local/share/nvim/plugged')
" Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'itchyny/lightline.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn'  }
Plug 'Shougo/neoinclude.vim'
Plug 'luochen1990/rainbow'
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'bhurlow/vim-parinfer', { 'for': ['lisp', 'clojure'] }
Plug 'tpope/vim-sleuth'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-classpath', { 'for': ['clojure', 'java', 'scala', 'kotlin'] }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'jparise/vim-graphql'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
" Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-crystal'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'honza/vim-snippets'
"Plug 'tpope/vim-sensible'

call plug#end()
" }}}
" General: {{{
let mapleader = " "
set fileencoding =utf-8
" theme
set background=dark
let g:lightline = { 'colorscheme': 'darcula', }
set noshowmode
let g:gruvbox_italic = 1
colorscheme OceanicNext 
set termguicolors
" set system clipboard keybindings
noremap <Leader>y "+y
noremap <Leader>p "+p
" Bind tab cycling
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
nnoremap <leader><leader> <c-^>
" Bind edit and reload nvim
nnoremap <leader>ev :e $MYVIMRC<CR>  
nnoremap <leader>sv :source $MYVIMRC<CR>     
nnoremap <leader>bd :%bd\|e#\|bd#<cr>
" save swap every 100ms of no input
set updatetime =100
" Auto syntax from filetype + indents
syntax on
filetype plugin indent on
" indent width
set tabstop =4
set shiftwidth =4
set softtabstop =4
" tab -> space conversion
set expandtab
" show current line
set number
" show up/down relative line positions
set relativenumber
" search case insensitive
set ignorecase
" Permanent Undo
set undodir=~/.vimdid
set undofile

" coc helpful settings
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" set foldmethod
set foldmethod=marker

" italic comments
hi Comment cterm = italic
" cursor
set guicursor =n-v-c-sm:block,i-ci-ve:hor100-Cursor,r-cr-o:ver100
" highlight current line in insert
autocmd InsertEnter,InsertLeave * set cul!
" show tabline always
set showtabline=2
" }}}
" RainbowBrackets: {{{
let g:rainbow_active = 1
" }}}
" MarkdownPreview: {{{
" dont auto close
let g:mkdp_auto_close = 0
" }}}
" Racer: {{{
let g:racer_cmd = expand('~/.cargo/bin/racer')
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
"au FileType rust nmap gd <Plug>(rust-def)
"au FileType rust nmap <leader>gd <Plug>(rust-doc)
" }}}
" Haskell: {{{
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
" }}}
" Polyglot: {{{
let g:polyglot_disabled = ['latex', 'kotlin']
" }}}
" Fugitive: {{{
set statusline +=%{FugitiveStatusline()}
let g:fugitive_git_executable = 'hub'
" }}}
" Deoplete: {{{
" set runtimepath +=~/.config/nvim/plugged/deoplete.nvim
" function! s:check_back_space() abort "{{{
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}
" " bind tab to complete
" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ deoplete#manual_complete()
" let g:deoplete#enable_at_startup = 1
" " delay 50ms, up to 50 finds, up to 8 threads, detect casing
" call deoplete#custom#option({
"   \ 'auto_complete_delay': 10,
"   \ 'camel_case': v:true,
"   \ 'max_list': 50,
"   \ 'num_processes': 8,
"   \ 'smart_case': v:true,
"   \ })
" }}}
" TernJS: {{{
" show types, docs, make case insensitive, select files to check js
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#filetypes = [
  \ 'jsx',
  \ 'javascript.jsx',
  \ 'vue',
  \ 'javascript'
  \ ]
" dont open scratch buffer
set completeopt -=preview
"}}}
" CtrlP: {{{
let g:ctrlp_custom_ignore = {
  \ 'dir': 'node_modules\|target\|\.git\|\.hg\|\.svn\|log\|tmp)$'
  \ }
let g:ctrlp_show_hidden = 1
" }}}
" Nerdtree: {{{
" Bind to Ctrl+n
map <silent> <C-n> :call ToggleNERDTreeFind()<CR>
nnoremap <silent> <Leader>n :call ToggleNERDTreeFind()<CR>
" Close nerdtree on enter
let NERDTreeQuitOnOpen=1
let g:sidebar_direction = ''
let g:NERDTreeWinPos=get(g:,'NERDTreeWinPos',sidebar_direction)                                      
" Close vim if last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
function! ToggleNERDTreeFind()
    if g:NERDTree.IsOpen()
        execute ':NERDTreeClose'
    else
      if (expand("%:t") != '')
        execute ":NERDTreeFind"
      else
        execute ":NERDTreeToggle"
      endif
    endif
endfunction
"}}}
" Coc: {{{
let g:coc_node_path = 'node'
let g:coc_global_extensions = [
  \  "coc-tsserver", 
  \  "coc-python",
  \  "coc-rls", 
  \  "coc-json", 
  \  "coc-eslint", 
  \  "coc-vetur",
  \  "coc-snippets",
  \  "coc-prettier"
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
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> <C-t> <Plug>(coc-diagnostic-info)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
"}}}
" Ale: {{{
" let g:ale_linters = {
"   \   'javascript': ['eslint'],
"   \   'python': ['black'],
"   \   'rust': ['rls'],
"   \   'fshap': ['dotnet-fsharplint'],
"   \   'typescript': ['tsserver','tslint'],
"   \   'html': ['prettier'],
"   \   'vue': ['vls']
"   \}

" let g:ale_fixers = {
"   \   'javascript': ['eslint'],
"   \   'python': ['black'],
"   \   'rust': ['rustfmt'],
"   \   'typescript': ['tslint'],
"   \   'html': ['prettier'],
"   \}
" nnoremap <C-t> :ALEHover<CR>
" " let g:ale_completion_enabled = 1
" " rust
" let g:ale_rust_cargo_check_tests = 1
" let g:ale_rust_cargo_use_clippy = 1
" let g:ale_rust_cargo_clippy_options = 'all'
" let g:ale_rust_rls_toolchain = "nightly-2019-08-01"
" " js
" let g:ale_javascript_eslint_executable = 'eslint'
" let g:ale_javascript_eslint_options = "--ignore-pattern '!node_modules/*'"
" " misc
" let g:ale_lint_on_text_changed = 'never'
" " let g:ale_lint_delay = 50
" let g:ale_echo_msg_format = '%linter%: %s'
" " autofix
" let g:ale_fix_on_save = 1
" let g:ale_linters_explicit = 1
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
" highlight clear ALEInfoSign
" highlight clear SignColumn
" }}}
" Fzf: {{{

nnoremap <C-p> :Files<CR>
nnoremap <leader>; :Buffers<CR>

"}}}
" Ripgrep: {{{
noremap <leader>s :Rg 
let g:rg_format = '%f:%l:%c:%m'
let g:rg_command = 'rg --no-heading --vimgrep'
"}}}
" Crystal: {{{
let g:crystal_auto_format = 1
" }}}
" Rooter: {{{
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
" }}}
" Lightline: {{{
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#filename_modifier = ':t'
" }}}
