" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

set nocompatible              " be iMproved, required
filetype off                  " required

set number relativenumber
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
""""""""""""""""""""""""""""""""""""""""" PLUGINS
Plugin 'dracula/vim'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'posva/vim-vue'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'mattn/emmet-vim'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
Plugin 'w0rp/ale'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
""""""""""""""""""""""""""""""""""""""""" END PLUGINS
call vundle#end()            " required
filetype plugin indent on    " required

" colorscheme
set background=dark    " Setting dark mode
colorscheme gruvbox

map <C-n> :NERDTreeClose<CR>
map ` :NERDTreeFocus<CR>

noremap <Leader>y "+y
map <leader>ru :%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g<cr>
set showcmd
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
let g:notes_directories = ['~/Documents/Notes']
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'javascript': ['eslint'], 'vue': ['eslint'],}
let g:user_emmet_leader_key=','

let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

let g:UltiSnipsExpandTrigger="<C-j>"
