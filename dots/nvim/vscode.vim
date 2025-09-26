nnoremap <Space> <Nop>
let mapleader = ' '

noremap <silent> <Leader>y "+y
noremap <silent> <Leader>p "+p

vmap y ygv<Esc>

" nnoremap <silent> H <Cmd>call <SID>switchEditor(v:count, 'next')<CR>
" nnoremap <silent> L <Cmd>call <SID>switchEditor(v:count, 'prev')<CR>

nnoremap <silent> H :Tabprevious<CR>
nnoremap <silent> L :Tabnext<CR>

nnoremap <silent> <leader>q :Quit<CR>

nnoremap <leader>ve :Edit ~/.config/nvim/vscode.vim<CR>
nnoremap <leader>vs :source ~/.config/nvim/vscode.vim<CR>


xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

nnoremap <C-p> <Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>

nnoremap <silent> ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

nnoremap <silent> <leader>ca <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
vnoremap <silent> <leader>ca <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
nnoremap <silent> <leader>co <Cmd>call VSCodeNotify('editor.action.organizeImports')<CR>
nnoremap <silent> <leader>cr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap <silent> <leader>b <Cmd>call VSCodeNotify('editor.action.inlineSuggest.trigger')<CR>
" nnoremap <silent> <C-[> <Cmd>call VSCodeNotify('workbench.action.showErrorsWarnings')<CR>

nnoremap <silent> gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap <silent> gd <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
nnoremap <silent> gD <Cmd>call VSCodeNotify('editor.action.goToDeclaration')<CR>
nnoremap <silent> gp <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
nnoremap <silent> gt <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
nnoremap <silent> gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>

nnoremap <silent> K <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

nnoremap <silent> <leader>e :nohl<CR>
