" space as leader
nnoremap <SPACE> <Nop>
let mapleader = ' '

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>

let g:which_key_map = {
\ 'a': ['ggVG', 'select-all'],
\ 't': [':term', 'terminal'],
\ ' ': [':q', 'quit']
\ }

autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')


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

let g:which_key_map.v = {
  \ 'name': '+vim',
  \ 'i': [':e ~/.config/nvim/init.vim', 'init.vim'],
  \ 'p': [':e ~/.config/nvim/plugins.vim', 'plugins.vim'],
  \ 's': [':e ~/.config/nvim/settings.vim', 'settings.vim'],
  \ 'k': [':e ~/.config/nvim/keymap.vim', 'keymap.vim'],
  \ 'l': [':e ~/.config/nvim/leader.vim', 'leader.vim'],
  \ 'v': {
    \ 'name': '+plug',
    \ 'i': [':PlugInstall', 'install'],
    \ 'u': [':PlugUpdate', 'update'],
    \ 'c': [':PlugClean', 'clean'],
    \ 's': [':PlugStatus', 'status'],
  \ },
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
  \ 't': [':NERDTreeToggle', 'nerd-tree']
  \ }

nnoremap <silent> <leader>bb :buffers<cr>:buffer<space>
let g:which_key_map.b = {
  \ 'name': '+buffer',
  \ 'b': ['buffers', 'go-to-buffer'],
  \ 'n': [':bnext', 'next-buffer'],
  \ 'p': [':bprev', 'previous-buffer'],
  \ }

" vim: set ft=vim et sw=2 ts=2:
