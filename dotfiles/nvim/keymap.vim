" Switch (`j`, `k`) and (`gj`, `gk`) around in normal and visual mode (so that
" it still works as normal in operator pending mode)
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k
nnoremap A g$i
vnoremap A g$i

" Focus or create a split in given direction
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>

" :w!! to force-save read-only files
cnoremap w!! w !sudo tee > /dev/null %

" Exit terminal mode with double-esc
:tnoremap <Esc><Esc> <C-\><C-n>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" coc specifics {{{

" Jump through coc diagnostics
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

" Code navigation
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Function and class text objects
xnoremap if <Plug>(coc-funcobj-i)
onoremap if <Plug>(coc-funcobj-i)
xnoremap af <Plug>(coc-funcobj-a)
onoremap af <Plug>(coc-funcobj-a)
xnoremap ic <Plug>(coc-classobj-i)
onoremap ic <Plug>(coc-classobj-i)
xnoremap ac <Plug>(coc-classobj-a)
onoremap ac <Plug>(coc-classobj-a)

" Show docs
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup cocgroup
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" }}}

" vim: set ft=vim et sw=2 ts=2:
