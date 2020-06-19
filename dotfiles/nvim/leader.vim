" space as leader
nnoremap <SPACE> <Nop>
let mapleader = ' '

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>

let g:which_key_map = {
\ 'a': ['ggVG', 'select-all'],
\ 't': [':term', 'terminal'],
\ 'n': [':NERDTreeToggle', 'nerd-tree'],
\ ' ': [':q', 'quit']
\ }

autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

xnoremap <leader>cf <Plug>(coc-format-selected)
xnoremap <leader>ca <Plug>(coc-codeaction-selected)

nnoremap <silent> <leader>bb :buffers<cr>:buffer<space>
let g:which_key_map.b = {
  \ 'name': '+buffer',
  \ 'b': ['buffers', 'go-to-buffer'],
  \ 'n': [':bnext', 'next-buffer'],
  \ 'p': [':bprev', 'previous-buffer'],
  \ }

let g:which_key_map.c = {
  \ 'name': '+code',
  \ 'r': ['<Plug>(coc-rename)', 'rename'],
  \ 'f': ['<Plug>(coc-format-selected)', 'format-selected'],
  \ 'a': ['<Plug>(coc-codeaction-selected)', 'codeaction-selected'],
  \ 'c': ['<Plug>(coc-fix-current)', 'correct-problem'],
  \ '[': [':CocPrev', 'prev'],
  \ ']': [':CocNext', 'next'],
  \ 'l': {
  \   'name': '+list',
  \   'c': [':CocList commands', 'commands'],
  \   'd': [':CocList diagnostics', 'diagnostics'],
  \   'e': [':CocList extensions', 'extensions'],
  \   'o': [':CocList outline', 'outline'],
  \   's': [':CocList -I symbols', 'symbols'],
  \   'l': [':CocListResume', 'resume-last'],
  \   },
  \ }

let g:which_key_map.g = {
  \ 'name': '+git',
  \ 'g': [':G', 'status'],
  \ 'c': [':Gcommit', 'commit'],
  \ 'l': [':GV', 'log'],
  \ 'f': [':Gdiff', 'file-diff'],
  \ 'd': [':G d', 'diff'],
  \ 'D': [':G ds', 'staged-diff'],
  \ 'b': [':Gblame', 'blame'],
  \ 'r': [':G remote', 'remote'],
  \ 'p': [':Gpush', 'push'],
  \ 'u': [':Gpull', 'pull']
  \ }

let g:which_key_map.r = {
  \ 'name': '+reformat',
  \ 't': [':retab', 'retab'],
  \ 's': [':%s/\s\+$', 'strip-trailing-whitespace'],
  \ 'j': [':%! python -m json.tool', 'json'],
  \ }

let g:which_key_map.t = {
  \ 'name': '+toggle',
  \ 'n': [':set relativenumber!', 'relativenumber'],
  \ 'p': [':set paste!', 'paste'],
  \ 'j': [':%! python -m json.tool', 'json'],
  \ }

let g:which_key_map.v = {
  \ 'name': '+vim',
  \ 'd': [':e ~/.config/nvim/dev_plugins.vim', 'dev_plugins.vim'],
  \ 'i': [':e ~/.config/nvim/init.vim', 'init.vim'],
  \ 'k': [':e ~/.config/nvim/keymap.vim', 'keymap.vim'],
  \ 'l': [':e ~/.config/nvim/leader.vim', 'leader.vim'],
  \ 'p': [':e ~/.config/nvim/plugins.vim', 'plugins.vim'],
  \ 'r': [':source ~/.config/nvim/init.vim', 'reload-config'],
  \ 's': [':e ~/.config/nvim/settings.vim', 'settings.vim'],
  \ 'v': {
    \ 'name': '+plug',
    \ 'i': [':PlugInstall', 'install'],
    \ 'u': [':PlugUpdate', 'update'],
    \ 'c': [':PlugClean', 'clean'],
    \ 's': [':PlugStatus', 'status'],
  \ },
  \ }

let g:which_key_map.w = {
  \ 'name': '+vimwiki',
  \ 'w': ['<Plug>VimwikiIndex', 'index'],
  \ 't': ['<Plug>VimwikiTabIndex', 'tab-index'],
  \ 's': ['<Plug>VimwikiUISelect', 'select'],
  \ 'i': ['<Plug>VimwikiDiaryIndex', 'diary-index'],
  \ 'W': ['<Plug>VimwikiMakeDiaryNote', 'make-note'],
  \ 'T': ['<Plug>VimwikiTabMakeDiaryNote', 'tab-make-note'],
  \ 'Y': ['<Plug>VimwikiMakeYesterdayDiaryNote', 'make-yesterday-note'],
  \ 'M': ['<Plug>VimwikiMakeTomorrowDiaryNote', 'make-tomorrow-note'],
  \ }

" vim: set ft=vim et sw=2 ts=2 fdm=indent:
