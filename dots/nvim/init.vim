" Plug: {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'morhetz/gruvbox'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'itchyny/lightline.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn'  }
Plug 'Shougo/neoinclude.vim'
Plug 'luochen1990/rainbow'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'bhurlow/vim-parinfer', { 'for': ['lisp', 'clojure'] }
Plug 'tpope/vim-sleuth'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-classpath', { 'for': ['clojure', 'java', 'scala', 'kotlin'] }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'jparise/vim-graphql'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'sheerun/vim-polyglot'
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install({'tag':1})}}
Plug 'pangloss/vim-javascript'
Plug 'cakebaker/scss-syntax.vim'
Plug 'rhysd/vim-crystal'

call plug#end()
" }}}
" General: {{{
set fileencoding =utf-8
" theme
set background=dark
let g:lightline = { 'colorscheme': 'wombat', }
set noshowmode
let g:gruvbox_italic = 1
colorscheme gruvbox
set termguicolors
" set system clipboard keybindings
noremap <Leader>y "*y
noremap <Leader>p "*p
" Bind tab cycling
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-k> :tabnext<CR>
nnoremap <Leader>n :tabnew<CR>
" save swap every 100ms of no input
set updatetime =100
" Auto syntax from filetype + indents
syntax on
filetype plugin indent on
" macro key
nnoremap <Space> @q
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
" italic comments
hi Comment cterm = italic
" cursor
set guicursor =n-v-c-sm:block,i-ci-ve:hor100-Cursor,r-cr-o:ver100
" highlight current line in insert
autocmd InsertEnter,InsertLeave * set cul!
" Python stuff
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
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
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
let g:polyglot_disabled = ['javascript', 'latex', 'rust', 'kotlin']
" }}}
" Gutentags: {{{
" show status
" set statusline +=%{gutentags#statusline()}
" set cache dir
" let g:gutentags_cache_dir = expand('~/.cache/gutentags_cache_dir')
" }}}
" Fugitive: {{{
set statusline +=%{FugitiveStatusline()}
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
"}}}
" Coc: {{{
let g:coc_node_path = 'node'

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

"}}}
" Asynchronous Lint Engine: {{{
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'python': ['black'],
  \   'rust': ['rls'],
  \   'fshap': ['dotnet-fsharplint']
  \}

let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'python': ['black'],
  \   'rust': ['rustfmt']
  \}
" rust
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_clippy_options = 'all'
let g:ale_rust_rls_executable = expand('~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rls')
" js
let g:ale_javascript_eslint_executable = 'eslint'
let g:ale_javascript_eslint_options = "--ignore-pattern '!node_modules/*'"
" misc
let g:ale_lint_delay = 50
let g:ale_echo_msg_format = '%linter%: %s'
" autofix
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear ALEInfoSign
highlight clear SignColumn
" }}}
let g:python3_host_prog = expand('~/.pyenv/shims/python')
let g:crystal_auto_format = 1
" vim: set sw=2 ts=2 sts=2 et tw=120 ft=vim fdm=marker:
