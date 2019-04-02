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
""""""""""""""""""""""""""""""""""""""""" END PLUGINS
call vundle#end()            " required
filetype plugin indent on    " required

" colorscheme
set background=dark    " Setting dark mode
colorscheme gruvbox 

map <C-C> :NERDTreeClose<CR>
map <C-n> :NERDTreeFocus<CR>

nnoremap <C-j> :tabprevious<CR>                                                                   
nnoremap <C-k> :tabnext<CR>
noremap <Leader>y "+y
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

map <leader>ru :%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g<cr>
set showcmd
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
let g:notes_directories = ['~/Documents/Notes']

