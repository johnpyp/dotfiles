" Plug: {{{
filetype plugin indent on
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:polyglot_disabled = ['latex', 'markdown', 'pandoc', 'go', 'vue', 'vim']

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'AndrewRadev/tagalong.vim'
Plug 'airblade/vim-rooter'
" Plug 'airblade/vim-gitgutter'
" Plug 'fatih/vim-go'
Plug 'ferrine/md-img-paste.vim'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'norcalli/nvim-colorizer.lua'
" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'pantharshit00/vim-prisma'
Plug 'plasticboy/vim-markdown'
"Plug 'romgrk/barbar.nvim'
" Plug 'romgrk/doom-one.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
" Plug 'tomtom/tcomment_vim'
" Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify'
Plug 'moll/vim-bbye'
" Plug 'sainnhe/edge'
Plug 'rakr/vim-one'
Plug 'rbong/vim-crystalline'
Plug 'arcticicestudio/nord-vim'
" Plug 'bagrat/vim-buffet'
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/artify.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'macthecadillac/lightline-gitdiff'
Plug 'maximbaz/lightline-ale'
Plug 'albertomontesg/lightline-asyncrun'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'yazgoo/unicodemoji'
Plug 'chrisbra/unicode.vim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'chriskempson/base16-vim'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mattn/emmet-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'windwp/nvim-ts-autotag'

Plug 'b3nj5m1n/kommentary'

" Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'TimUntersberger/neogit'
Plug 'kdheepak/lazygit.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Plug 'windwp/nvim-autopairs'
" 
" Plug 'neovim/nvim-lspconfig'
" Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
" 
" Plug 'onsails/lspkind-nvim'
" 
" Plug 'hrsh7th/nvim-compe'
" Plug 'kabouzeid/nvim-lspinstall'
" 
" Plug 'RishabhRD/popfix'
" Plug 'RishabhRD/nvim-lsputils'
" 
" Plug 'tamago324/nlsp-settings.nvim'

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
colorscheme one
let g:one_allow_italics = 1 " I love italic for comments
syntax on
set tabstop=2 softtabstop=0 shiftwidth=2 expandtab smarttab
set number
set ignorecase
set undofile
set conceallevel=0
set hidden
set nobackup
set nowritebackup
set backupcopy=yes
set cmdheight=2
set updatetime=150
set shortmess+=c
set signcolumn=yes
set showbreak=﬌
set linebreak
set foldmethod=marker
set showtabline=2
set inccommand=split
set mouse=a
highlight Comment cterm=italic gui=italic
set guicursor=
set guicursor=a:blinkon0-blinkoff0,n-v-c-sm:block,i-ci-ve:hor100-Cursor,r-cr-o:ver100
set completeopt=menuone,noselect
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
autocmd FileType json syntax match Comment +\/\/.\+$+
command! ProfileMe :profile start profile.log <bar> profile func * <bar> profile file *
command! ProfileStop :profile pause
" }}}
" Platform: {{{
if has("mac")
  let g:python3_host_prog = '/usr/bin/python3'
  let g:clipboard = {
    \ 'name': 'pbcopy',
    \ 'copy': {
    \    '+': 'pbcopy',
    \    '*': 'pbcopy',
    \  },
    \ 'paste': {
    \    '+': 'pbpaste',
    \    '*': 'pbpaste',
    \ },
    \ 'cache_enabled': 0,
    \ }
endif
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

map! <F13> <Nop>
map! <F14> <Nop>

nnoremap <silent> H :bp<CR>
nnoremap <silent> L :bn<CR>

nnoremap <silent> <C-h> :BufferMovePrevious<CR>
nnoremap <silent> <C-l> :BufferMoveNext<CR>
" inoremap <silent> <C-h> <ESC> :BufferMovePrevious<CR>
" inoremap <silent> <C-l> <ESC> :BufferMoveNext<CR>

nnoremap <leader>q :Bdelete<CR>
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


" Fzf:
nnoremap <silent> <C-i> :Rg<CR>
nnoremap <silent> <C-p> :Files<CR>
" nnoremap <silent> <leader>l :Buffers<CR>

" Fugitive:
" nnoremap <leader>gs :Git<CR>
" nnoremap <leader>gp :Git push<CR>
" nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :LazyGit<CR>

" Markdown:
nnoremap <silent> <leader>mc :call CompileMarkdownTerm()<CR>
nnoremap <silent> <leader>mo :call system(ZathuraPdf(expand("%:p")) . "&!")<CR>
nnoremap <silent> <leader>mp :call mkdp#util#toggle_preview()<CR>


map <leader>w <C-w>

" nnoremap <silent> <leader>n :NvimTreeToggle<CR>
" inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))

let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_leader_key=','

"let delimitMate_quotes = "\" ' `"
"au FileType markdown let b:delimitMate_quotes = "\" ' ` $"
" }}}
" Coc: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extensions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" }}}"""
" Fern: {{{
function! s:init_fern() abort

  nnoremap <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
  nmap <buffer><silent> <Plug>(fern-action-open-and-close)
      \ <Plug>(fern-action-open)
      \ <Plug>(fern-close-drawer)

  nmap <buffer><expr>
      \ <Plug>(fern-my-expand-or-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-collapse)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

  nmap <buffer><silent><expr>
        \ <Plug>(fern-my-open-or-expand)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open-and-close)",
        \   "\<Plug>(fern-my-expand-or-collapse)",
        \ )

  nmap <buffer><silent><expr>
        \ <Plug>(fern-my-collapse-or-leave)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open-and-close)",
        \   "\<Plug>(fern-action-expand)",
        \ )
  nmap <buffer><nowait> l <Plug>(fern-my-open-or-expand)
  nmap <buffer><nowait> <CR> <Plug>(fern-my-open-or-expand)
  nmap <buffer><nowait> x <Plug>(fern-action-collapse)
  nmap <buffer><nowait> u <Plug>(fern-action-leave)

  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>

  " Define NERDTree like mappings
  " nmap <buffer> o <Plug>(fern-action-open:edit)
  " nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  " nmap <buffer> t <Plug>(fern-action-open:tabedit)
  " nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  " nmap <buffer> i <Plug>(fern-action-open:split)
  " nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  " nmap <buffer> s <Plug>(fern-action-open:vsplit)
  " nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
  " nmap <buffer> ma <Plug>(fern-action-new-path)
  " nmap <buffer> P gg
  "
  " nmap <buffer> C <Plug>(fern-action-enter)
  " nmap <buffer> u <Plug>(fern-action-leave)
  " nmap <buffer> r <Plug>(fern-action-reload)
  " nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
  " nmap <buffer> cd <Plug>(fern-action-cd)
  " nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>
  "
  " nmap <buffer> I <Plug>(fern-action-hide-toggle)

  nmap <buffer> q :<C-u>quit<CR>
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

let g:fern#renderer = "nerdfont"
" }}}
" Other Plugin Config: {{{
" lua require'colorizer'.setup({ "*", }, { mode = 'foreground' })

set viminfo='100,n$HOME/.vim/files/info/viminfo

let loaded_netrwPlugin = 1

let g:csv_nomap_h = 1
let g:csv_nomap_l = 1


" let g:edge_enable_italic = 1
" let g:edge_better_performance = 1
" " let g:lightline.colorscheme = 'edge'
" let g:edge_style = 'edge'

let bufferline = {}
let bufferline.animation = v:false
let bufferline.closable = v:false
let bufferline.maximum_padding = 2

let g:netrw_liststyle = 3

let g:floaterm_autoclose = 1

let g:sleuth_automatic = 1

" let g:fugitive_git_executable = 'hub'
let g:fugitive_pty = 0

let g:tagalong_additional_filetypes = ['vue']

let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_patterns = [".git", "_darcs", ".hg", ".bzr", ".svn", ".project", ".projectkeep"]

let g:airline_extensions = ["tabline", "coc", "branch"]

let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_theme="tomorrow"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right                                                           
" let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline                                                 
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline

" function! g:BuffetSetCustomColors()
"   hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#00FF00 guifg=#000000
" endfunction
"
" let g:buffet_powerline_separators = 0
" let g:buffet_tab_icon = "\uf00a"
" let g:buffet_left_trunc_icon = "\uf0a8"
" let g:buffet_right_trunc_icon = "\uf0a9"

" function! StatusLine(...)
"   return crystalline#mode() . crystalline#right_mode_sep('')
"         \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . '%='
"         \ . crystalline#left_sep('', 'Fill') . ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
" endfunction
" let g:crystalline_enable_sep = 1
" let g:crystalline_statusline_fn = 'StatusLine'
" let g:crystalline_theme = 'onedark'
" set laststatus=2
"
" set tabline=%!crystalline#bufferline()
" set showtabline=2


" function! StatusLine(current, width)
"   let l:s = ''
"
"   if a:current
"     let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
"   else
"     let l:s .= '%#CrystallineInactive#'
"   endif
"   let l:s .= ' %f%h%w%m%r '
"   if a:current
"     let l:s .= crystalline#right_sep('', 'Fill') . '%{fugitive#head()}'
"   endif
"
"   let l:s .= '%='
"   if a:current
"     let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
"     let l:s .= crystalline#left_mode_sep('')
"   endif
"   if a:width > 80
"     let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
"   else
"     let l:s .= ' '
"   endif
"
"   return l:s
" endfunction

" function! BufferlineParts(buf, max_width) abort
"   let [l:empty, l:mod, l:left, l:nomod] = crystalline#get_tab_strings()
"   let l:right = getbufvar(a:buf, '&mod') ? l:mod : l:nomod
"   let l:name = pathshorten(bufname(a:buf))
"   let l:short_name = l:name[-a:max_width : ]
"   if l:short_name ==# ''
"     let l:short_name = l:empty
"   endif
"   return l:name
" endfunction
"
" function! TabLine()
"   let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
"   return crystalline#bufferline(2, len(l:vimlabel), 1, 0, 'BufferlineParts') . '%=%#CrystallineTab# ' . l:vimlabel
" endfunction
"
" let g:crystalline_enable_sep = 0
" let g:crystalline_statusline_fn = 'StatusLine'
" let g:crystalline_tabline_fn = 'TabLine'
" let g:crystalline_theme = 'onedark'
"
" set showtabline=2
" set guioptions-=e
" set laststatus=2


let g:VM_theme = 'codedark'
let g:VM_leader = ','
let g:VM_maps = {}
let g:VM_maps['Motion ,'] = ',,'

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
        :FloatermNew "$HOME/.scripts/compile-md" "%"
    endif
endfunction

command! -nargs=0 CompileMarkdown :call CompileMarkdownTerm()

let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 1
let g:mkdp_open_to_the_world = 0
function! g:Open_browser(url)
    silent exec "!brave --app=" . a:url
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
" Lightline: {{{
function! CocCurrentFunction()"{{{
  return get(b:, 'coc_current_function', '')
endfunction"}}}
function! Devicons_Filetype()"{{{
  " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction"}}}
function! Devicons_Fileformat()"{{{
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction"}}}
function! Artify_active_tab_num(n) abort"{{{
  return Artify(a:n, 'bold')." \ue0bb"
endfunction"}}}
function! Tab_num(n) abort"{{{
  return a:n." \ue0bb"
endfunction"}}}
function! Gitbranch() abort"{{{
  if gitbranch#name() !=# ''
    return gitbranch#name()." \ue725"
  else
    return "\ue61b"
  endif
endfunction"}}}
function! Artify_inactive_tab_num(n) abort"{{{
  return Artify(a:n, 'double_struck')." \ue0bb"
endfunction"}}}
function! Artify_lightline_tab_filename(s) abort"{{{
  return Artify(lightline#tab#filename(a:s), 'monospace')
endfunction"}}}
function! Artify_lightline_mode() abort"{{{
  return Artify(lightline#mode(), 'monospace')
endfunction"}}}
function! Artify_line_percent() abort"{{{
  return Artify(string((100*line('.'))/line('$')), 'bold')
endfunction"}}}
function! Artify_line_num() abort"{{{
  return Artify(string(line('.')), 'bold')
endfunction"}}}
function! Artify_col_num() abort"{{{
  return Artify(string(getcurpos()[2]), 'bold')
endfunction"}}}
function! Artify_gitbranch() abort"{{{
  if gitbranch#name() !=# ''
    return Artify(gitbranch#name(), 'monospace')." \ue725"
  else
    return "\ue61b"
  endif
endfunction"}}}
set laststatus=2  " Basic
set noshowmode  " Disable show mode info
augroup lightlineCustom
  autocmd!
  autocmd BufWritePost * call lightline_gitdiff#query_git() | call lightline#update()
augroup END
let g:lightlineArtify = 0
let g:lightline = {}
let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf529"
let g:lightline#ale#indicator_errors = "\uf00d"
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline_gitdiff#indicator_added = '+'
let g:lightline_gitdiff#indicator_deleted = '-'
let g:lightline_gitdiff#indicator_modified = '*'
let g:lightline_gitdiff#min_winwidth = '70'
let g:lightline#asyncrun#indicator_none = ''
let g:lightline#asyncrun#indicator_run = 'Running...'
let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'gitbranch', 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'pomodoro' ],
    \            [ 'asyncrun_status', 'coc_status' ] ]
    \ }
let g:lightline.inactive = {
    \ 'left': [ ['mode', 'paste'], [ 'gitbranch', 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
    \ 'right': [ [ 'lineinfo' ] ]
    \ }
let g:lightline.tabline = {
    \ 'left': [ [ 'vim_logo', 'buffers' ] ],
    \ 'right': []
    \ }
let g:lightline.tab = {
    \ 'active': [ 'tabnum', 'filename', 'modified' ],
    \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
let g:lightline.tab_component = {
      \ }
let g:lightline.tab_component_function = {
      \ 'artify_activetabnum': 'Artify_active_tab_num',
      \ 'artify_inactivetabnum': 'Artify_inactive_tab_num',
      \ 'artify_filename': 'Artify_lightline_tab_filename',
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': 'Tab_num'
      \ }
let g:lightline.component = {
      \ 'artify_gitbranch' : '%{Artify_gitbranch()}',
      \ 'artify_mode': '%{Artify_lightline_mode()}',
      \ 'artify_lineinfo': "%2{Artify_line_percent()}\uf295 %3{Artify_line_num()}:%-2{Artify_col_num()}",
      \ 'gitstatus' : '%{lightline_gitdiff#get_status()}',
      \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
      \ 'vim_logo': "\ue62b",
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%f',
      \ 'filename': '%t',
      \ 'filesize': "%{HumanSize(line2byte('$') + len(getline('$')))}",
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
      \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
      \ 'modified': '%M',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'percent': '%2p%%',
      \ 'percentwin': '%P',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'lineinfo': '%2p%% %3l:%-2v',
      \ 'line': '%l',
      \ 'column': '%c',
      \ 'close': '%999X X ',
      \ 'winnr': '%{winnr()}'
      \ }
let g:lightline.component_function = {
      \ 'gitbranch': 'Gitbranch',
      \ 'devicons_filetype': 'Devicons_Filetype',
      \ 'devicons_fileformat': 'Devicons_Fileformat',
      \ 'coc_status': 'coc#status'
      \ }
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors',
      \ 'linter_ok': 'lightline#ale#ok',
      \ 'asyncrun_status': 'lightline#asyncrun#status',
      \ 'coc_currentfunction': 'CocCurrentFunction',
      \ 'buffers': 'lightline#bufferline#buffers'
      \ }
let g:lightline.component_type = {
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error',
      \ 'buffers': 'tabsel'
      \ }
let g:lightline.component_visible_condition = {
      \ 'gitstatus': 'lightline_gitdiff#get_status() !=# ""'
      \ }
let g:lightline.colorscheme = 'onedark'
" }}}
" Imports: {{{
set runtimepath^=/home/johnpyp/code/coc-prisma
" source $HOME/.config/nvim/coc.vim
" source $HOME/.config/nvim/luamode.vim
source $HOME/.config/nvim/coc.vim
" lua require("entrypoint")
lua require("plugins.treesitter")
lua require("plugins.kommentary")
" lua require("plugins.neogit")
" }}}
