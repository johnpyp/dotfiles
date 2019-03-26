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

""""""""""""""""""""""""""""""""""""""""" END PLUGINS
call vundle#end()            " required
filetype plugin indent on    " required

" colorscheme

colorscheme gruvbox
set background=dark    " Setting dark mode

map <C-C> :NERDTreeClose<CR>
map <C-n> :NERDTreeFocus<CR>

nnoremap <C-j> :tabprevious<CR>                                                                   
nnoremap <C-k> :tabnext<CR>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>ru :%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
set showcmd
