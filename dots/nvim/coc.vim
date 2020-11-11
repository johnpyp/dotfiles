"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extensions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_node_path = 'node'
let g:coc_global_extensions = [
            \  "coc-css",
            \  "coc-cssmodules",
            \  "coc-emmet",
            \  "coc-eslint",
            \  "coc-go",
            \  "coc-html",
            \  "coc-java",
            \  "coc-json",
            \  "coc-lists",
            \  "coc-metals",
            \  "coc-pairs",
            \  "coc-prettier",
            \  "coc-python",
            \  "coc-rust-analyzer",
            \  "coc-snippets",
            \  "coc-svg",
            \  "coc-tailwindcss",
            \  "coc-texlab",
            \  "coc-tsserver",
            \  "coc-vetur",
            \  "coc-vimlsp",
            \  "coc-xml",
            \  "coc-yaml",
            \  "coc-explorer"
            \]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybinds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gD :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>ct <Plug>(coc-diagnostic-info)
nmap <silent> <leader>cr <Plug>(coc-rename)
nmap <silent> <leader>co :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nmap <silent> <leader>cs :call CocActionAsync('showSignatureHelp')<CR>
nmap <silent> <leader>ca :CocAction<CR>
xmap <silent> <leader>ca :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nnoremap <nowait> <leader>cl  :<C-u>CocList diagnostics<cr>

vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <silent> F :call CocAction('format')<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>

nnoremap <silent> <leader>n :execute "CocCommand explorer" getcwd()<CR>
"nnoremap <silent> <leader>s :CocRg<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if $CONDA_PREFIX == ""
  let s:current_python_path="/usr/bin/python"
else
  let s:current_python_path=$CONDA_PREFIX.'/bin/python'
endif
call coc#config('python', {'pythonPath': s:current_python_path})

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup cocgroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType json setlocal formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd FileType markdown,pandoc,tex,latex let b:coc_pairs = [["$", "$"]]

    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=* -complete=custom,s:GrepArgs CocRg exe 'CocList -I grep -i '.<q-args>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')

  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! s:GrepArgs(...)
  let list = ['-S', '--smart-case', '-w', '--word-regexp', '-e', '--regexp', '--ignore-files']
  return join(list, "\n")
endfunction
