" Toggle between line numbers
nnoremap <silent> <F4> :set nornu!<CR>

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

" vim: set ft=vim et sw=2 ts=2:
