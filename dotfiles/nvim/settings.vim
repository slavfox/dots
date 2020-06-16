" General
filetype plugin on 
filetype plugin indent on
syntax on
set title
set ttyfast
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c

" Colors
set background=dark
set termguicolors
colorscheme onedark

" Wrapping
set textwidth=79
set colorcolumn=+1
set linebreak
set formatoptions+=t

" trailing whitespace
set list

" Search
set ignorecase
set smartcase
set incsearch
set inccommand=nosplit

" automatically change window's cwd to file's dir
set autochdir

" Relative line numbers
set nu
set rnu

set completeopt=longest,menuone,preview

set splitbelow
set splitright

set expandtab
set tabstop=4
set shiftwidth=4
" vim: set ft=vim et sw=2 ts=2:
