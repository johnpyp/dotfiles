" Plug: {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'justinmk/vim-dirvish'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'alaviss/nim.nvim'
Plug 'dense-analysis/ale'
Plug 'eraserhd/parinfer-rust', {'do': 'nix-shell --run \"cargo build --release \"'}
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn'  }
Plug 'itchyny/lightline.vim'
Plug 'jparise/vim-graphql'
Plug 'jremmen/vim-ripgrep'
Plug 'liuchengxu/vim-which-key'
Plug 'mattn/emmet-vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc-eslint', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'rhysd/vim-crystal'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'udalov/kotlin-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
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
colorscheme  hybrid
set termguicolors
" save swap every 100ms of no input
set updatetime =100
" Auto syntax from filetype + indents
syntax on
filetype plugin indent on
" indent width
set tabstop =4
set shiftwidth =4
set softtabstop =4
se nostartofline
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

" italic comments
hi Comment cterm = italic
" cursor
set guicursor =n-v-c-sm:block,i-ci-ve:hor100-Cursor,r-cr-o:ver100
" highlight current line in insert
autocmd InsertEnter,InsertLeave * set cul!
" show tabline always
set showtabline=2

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
" }}}
" MarkdownPreview: {{{
" dont auto close
let g:mkdp_auto_close = 0
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
let g:polyglot_disabled = ['latex', 'vue', 'go', 'kotlin']
" }}}
" Fugitive: {{{
set statusline +=%{FugitiveStatusline()}
let g:fugitive_git_executable = 'hub'
" }}}
" Nerdtree: {{{
" Bind to Ctrl+n
" Close nerdtree on enter
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeWinSize = 45
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeNaturalSort = 1
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

let g:NERDTreeIgnore = ['^node_modules$']
autocmd FileType nerdtree setlocal nolist
"}}}
" Coc: {{{
let b:coc_root_patterns = ['package.json']
let g:coc_node_path = 'node'
let g:coc_global_extensions = [
  \  "coc-tsserver",
  \  "coc-python",
  \  "coc-rls",
  \  "coc-json",
  \  "coc-snippets",
  \  "coc-prettier",
  \  "coc-emmet",
  \  "coc-go",
  \  "coc-lists",
  \  "coc-java"
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
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
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

"}}}
" Ale: {{{
let g:ale_linters = {
  \   'crystal': 'all',
  \   'nix': 'all',
  \   'vim': 'all',
  \   'rust': []
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
" Ripgrep: {{{
" let g:rg_format = '%f:%l:%c:%m'
let g:rg_command = 'rg --vimgrep -F'
let g:rg_highlight = 1
let g:rg_derive_root = 1
"}}}
" Crystal: {{{
"let g:crystal_auto_format = 1
" }}}
" Clojure: {{{
"let g:salve_auto_start_repl = 1
" }}}
" Rooter: {{{
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
" }}}
" Lightline: {{{
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'tabline': {
  \   'left': [ [ 'buffers'] ]
  \ },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ },
  \ }


autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
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
"let g:go_highlight_variable_declarations = 1
"let g:go_highlight_variable_assignments = 1
" }}}
" Vineger: {{{
autocmd FileType netrw setl bufhidden=delete
" }}}
" DelimitMate: {{{
"let delimitMate_expand_cr = 1
" }}}
" LSPs: {{{
""" Kotlin
if empty(glob('~/lsp/kotlin-language-server/server/bin/kotlin-language-server'))
  !curl -fLo ~/lsp/kotlin-language-server/server.zip --create-dirs
    \ https://github.com/fwcd/kotlin-language-server/releases/latest/download/server.zip
  !unzip ~/lsp/kotlin-language-server/server.zip -d ~/lsp/kotlin-language-server
endif

""" Clojure
if empty(glob('~/lsp/clojure'))
  !curl -fLo ~/lsp/clojure/clojure-lsp --create-dirs
    \ https://github.com/snoe/clojure-lsp/releases/latest/download/clojure-lsp
  !chmod +x ~/lsp/clojure/clojure-lsp

endif

""" Metals
if empty(glob('~/lsp/metals-vim'))
  !coursier bootstrap
        \ --java-opt -Xss4m
        \ --java-opt -Xms100m
        \ --java-opt -Dmetals.client=coc.nvim
        \ org.scalameta:metals_2.12:0.7.6
        \ -r bintray:scalacenter/releases
        \ -r sonatype:snapshots
        \ -o ~/lsp/metals-vim -f
endif


" }}}
" WhichKey: {{{
noremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=250
call which_key#register('<Space>', "g:which_key_map")
let g:which_key_map = {}
let g:which_key_use_floating_win = 0
let g:which_key_map.g = {
      \ 'name' : 'Git' ,
      \ 's' : 'Git Status',
      \ 'c' : 'Git Commit',
      \ 'p' : 'Git Push',
      \ 'b' : 'Git Blame',
      \ }

let g:which_key_map.f = {
      \ 'name' : 'File' ,
      \ 's' : 'Search (rg)',
      \ 'f' : 'Find File (files)',
      \ }

let g:which_key_map.b = {
      \ 'name' : 'Buffer' ,
      \ 'p' : 'Prev buffer',
      \ 'n' : 'Next buffer',
      \ }

let g:which_key_map.v = {
      \ 'name' : 'Vim' ,
      \ 'e' : 'Edit .vimrc',
      \ 's' : 'Source .vimrc',
      \ }
let g:which_key_map.c = {
      \ 'name' : 'Coc' ,
      \ 'a' : 'Code Actions',
      \ 't' : 'Diagnostic Info',
      \ 'd' : 'Definition',
      \ 'D' : 'Type definition',
      \ 'i' : 'Implementation',
      \ 'r' : 'Actions',
      \ 'f' : 'References',
      \ 'o' : 'Organize Imports',
      \ 'h' : 'Hover Info',
      \ }
let g:which_key_map.a = {
      \ 'name' : 'ALE' ,
      \ 'a' : 'Code Actions',
      \ 't' : 'ALE Detail',
      \ 'd' : 'Go To Definition',
      \ 'i' : 'ALE Info',
      \ 'o' : 'Organize Imports',
      \ 'h' : 'Hover Info',
      \ 'f' : 'ALE Fix',
      \ }
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" }}}
" KEYBINDS: {{{
""" General:
" set system clipboard keybindings
noremap <Leader>y "+y
noremap <Leader>p "+p

nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>W :noa w<CR>
nnoremap <leader>Q :BufOnly<CR>
nnoremap <leader><leader> :Files<CR>
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
nnoremap <silent> <leader>sc :nohl<CR>

nnoremap j gj
nnoremap k gk
nnoremap <C-k> 5k
nnoremap <C-j> 5j
""" Coc:
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> <leader>ct <Plug>(coc-diagnostic-info)

nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cD <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nnoremap          <leader>ca :CocAction<CR>
nmap          <leader>cf <Plug>(coc-fix-current)
nnoremap <silent> <leader>co :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <silent> F :call CocAction('format')<CR>:ALEFix<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

nnoremap <silent> <leader>cl  :<C-u>CocList diagnostics<cr>

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
" nnoremap <leader>gd :Gvdiff<CR>
" nnoremap gdh :diffget //2<CR>
" nnoremap gdh :diffget //3<CR>

""" NERDTree:
" map <silent> <C-n> :call ToggleNERDTreeFind()<CR>
nnoremap <silent> <Leader>n :call ToggleNERDTreeFind()<CR>

""" FZF:
nnoremap <C-p> :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>

""" Ripgrep:
noremap <leader>fs :Rg<space>

""" Buffers:
map <leader>w <C-w>
" }}}
