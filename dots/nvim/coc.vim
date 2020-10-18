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
            \]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybinds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-tab>"

let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>ct <Plug>(coc-diagnostic-info)
nmap <silent> <leader>cr <Plug>(coc-rename)
nmap <silent> <leader>cf <Plug>(coc-fix-current)
nmap <silent> <leader>co :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nmap <silent> <leader>cs :call CocActionAsync('showSignatureHelp')<CR>
nmap <silent> <leader>ca :CocAction<CR>
xmap <silent> <leader>ca :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>

vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <silent> F :call CocAction('format')<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>

nnoremap <silent><nowait> <leader>cl  :<C-u>CocList diagnostics<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup cocgroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType json setlocal formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)

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
