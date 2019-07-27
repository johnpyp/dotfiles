" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

set nocompatible              " be iMproved, required
filetype off                  " required

set number relativenumber
" colorscheme
set background=dark    " Setting dark mode
noremap <Leader>y "+y
map <leader>ru :%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g<cr>
set showcmd
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
