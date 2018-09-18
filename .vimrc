""" Welcome to my .vimrc!


""" Plug install plugins

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Best absolutely must-have plugin
Plug 'gioele/vim-autoswap'

""" Development """
"Plug '~/clairvoyant.vim'

" Let's be sensible
Plug 'tpope/vim-sensible'

" Autodetect indentation
Plug 'tpope/vim-sleuth'

" Persist sessions
Plug 'thaerkh/vim-workspace'


"""
" Interface tweaks
"""

    " Nice start screen with recent files etc
    Plug 'mhinz/vim-startify'

    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Smarter tab line
    let g:airline#extensions#tabline#enabled = 1
    " Powerline fonts
    let g:airline_powerline_fonts = 1
    " Tabline
    let g:airline#extensions#tabline#enabled=1

    " NerdTree
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    map <F3> :NERDTreeToggle<CR>
    let NERDTreeQuitOnOpen = 1
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1

    " DevIcons
    Plug 'ryanoasis/vim-devicons'

    " Fzf
    Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins' }
    map <F2> :Denite buffer file_rec<CR>

    " Tags

        Plug 'majutsushi/tagbar'

        " Has to be there for easytags
        Plug 'xolox/vim-misc'
        Plug 'xolox/vim-easytags'
        " be quiet
        let g:easytags_suppress_report = 1

    " Gitgutter
    Plug 'airblade/vim-gitgutter'

    " Color schemes
    Plug 'dylanaraps/wal.vim'

    " Distraction-free mode!
    Plug 'junegunn/goyo.vim'

    Plug 'junegunn/limelight.vim'
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!


"""
" Syntax etc
"""

    " Puppet files syntax coloring
    Plug 'rodjek/vim-puppet'

    " Inline evaluation!
    Plug 'metakirby5/codi.vim', { 'on': 'Codi' }

    " Static checking (screw syntastic)
    Plug 'w0rp/ale'
    let g:ale_linters = {'python': []}
    let g:ale_set_quickfix = 1
    let g:ale_fixers = {'cpp': ['clang-format', 'remove_trailing_lines', 'trim_whitespace']}
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_cpp_clangcheck_options = '-- -Wall -std=c++11 -x c++'
    let g:ale_cpp_clangtidy_options = '-Wall -std=c++11 -x c++'

    " Python stuff

        " Python mode
        Plug 'python-mode/python-mode', {'for': 'python'}
        let g:pymode_folding=0
        let g:pymode_syntax_print_as_function=1
        let g:pymode_rope_complete_on_dot = 0


        " Jedi
        " Sometimes I get tired of Python mode, so I switch to using Jedi
        " Plug 'davidhalter/jedi-vim', {'for': 'python'}

        " let g:jedi#goto_command = '<leader>pd'
        " let g:jedi#goto_assignments_command = '<leader>pg'
        " let g:jedi#rename_command = '<leader>pr'

        " let g:jedi#completions_enabled = 0

        " PEP8
        "Plug 'nvie/vim-flake8'

    " Lilypond

    Plug 'matze/vim-lilypond'

    " Fish

    Plug 'dag/vim-fish'

    " Haskell

    Plug 'neovimhaskell/haskell-vim'
    Plug 'eagletmt/ghcmod-vim'
    Plug 'eagletmt/neco-ghc'

    " C / CPP

    set cino=l1,(0,u0,Ws,m1
    Plug 'zchee/deoplete-clang'
    Plug 'Shougo/neoinclude.vim'
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
    let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
    let g:deoplete#sources#clang#std = {'c': 'c11', 'cpp': 'c++11', 'objc': 'c11', 'objcpp': 'c++1z'}

                " Make it work like supertab
                inoremap <silent><expr> <TAB>
                                \ pumvisible() ? "\<C-n>" :
                                \ <SID>check_back_space() ? "\<TAB>" :
                                \ deoplete#mappings#manual_complete()
                                function! s:check_back_space() abort "{{{
                                let col = col('.') - 1
                                return !col || getline('.')[col - 1]  =~ '\s'
                endfunction"}}}

                inoremap <silent><expr> <S-TAB>
                                \ pumvisible() ? "\<C-p>" : "\<TAB>"

    " GDScript

    Plug 'calviken/vim-gdscript3'

    " Completions

        " Deoplete

        Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
        Plug 'zchee/deoplete-jedi'
        let g:deoplete#sources#jedi#show_docstring = 1
        let g:deoplete#enable_at_startup = 1
        "
        " I can't remember why this was here, but it seems important, so if
        " shit stops working, uncomment this
        "
        if !exists('g:deoplete#omni#input_patterns')
            let g:deoplete#omni#input_patterns = {}
        endif

        " So that multiple cursors doesn't get fucky
        function g:Multiple_cursors_before()
            let g:deoplete#disable_auto_complete = 1
        endfunction
        function g:Multiple_cursors_after()
            let g:deoplete#disable_auto_complete = 0
        endfunction


        " Supertab

        " Plug 'ervandew/supertab'
        " Default completion type: deoplete
        " let g:SuperTabContextDefaultCompletionType = "<c-n>"
        " let g:SuperTabDefaultCompletionType = "<c-n>"
        " let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
        " let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

        " Accept completion with enter as well as C-y
        inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


"""
" Fancy key mappings and additional functions
"""

    " Automatically close parentheses etc
    Plug 'jiangmiao/auto-pairs'

    " Two-character seek movement
    Plug 'justinmk/vim-sneak'

    " Surround.vim
    Plug 'tpope/vim-surround'

    " Git integration
    Plug 'tpope/vim-fugitive'

    " Commentary
    Plug 'tpope/vim-commentary'

    " Leader key hints
    Plug 'hecal3/vim-leader-guide'

    " Vimwiki
    Plug 'vimwiki/vimwiki'
    let g:vimwiki_list = [{}, 
            \ {'path': '~/Orbital/doc/src', 'path_html': '~/Orbital/doc/html'}]


call plug#end()


""""""""""""""""""""""""""""""
" Non plugin-specific settings
set guifont=LiberationMonoPowerline\ Nerd\ Font\ Book\ 10

" Always display airline
set laststatus=2

set textwidth=79
set linebreak
set fo+=t

" Pretty colors
set background=dark
" set termguicolors
colors wal
let g:airline_theme='wal'

" if file is changed outside Vim
set autoread

set encoding=utf8
filetype plugin indent on
filetype plugin on      " Enables the ftplugin options
set autoindent
syntax on
set history=1000
set wildmenu
set title
set ttyfast
set inccommand=nosplit
set completeopt=longest,menuone,preview

" set search case to a good configuration http://vim.wikia.com/wiki/Searching
set ignorecase
set smartcase
set incsearch

" wrap text
set textwidth=79
set colorcolumn=+1

" trailing whitespace
set list

" automatically change window's cwd to file's dir
set autochdir

" Current line number
set nu

" Relative line numbers
nnoremap <silent> <F4> :set nornu!<CR>
set rnu

" Saving read-only files
cnoremap w!! w !sudo tee > /dev/null %


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader guide & mappings
"
" space as leader
nnoremap <SPACE> <Nop>
let mapleader = ' '

let g:leaderGuide_submode_mappings = {'<C-C>': 'win_close', '<C-F>': 'page_down', '<C-B>': 'page_up'}


" exit splits easily
nnoremap <silent> <leader><leader> :q<cr>

" Inline evaluation
nnoremap <silent> <leader>c :Codi!!<cr>

" select the entire buffer
nnoremap <silent> <leader>a ggVG

nnoremap <silent> <leader>t :TagbarToggle<CR>

" Pretty print JSON
nnoremap <silent> <leader>j :%! python -m json.tool<cr>

" r - refactoring functions

    " Howdoi
    nnoremap <silent> <leader>rh mH:r !howdoi <C-R>=shellescape(getline('.'))<CR><CR>'Hdd

    " Strip trailing whitespace
    nnoremap <silent> <leader>rs :%s/\s\+$<cr>

    " Retab
    nnoremap <silent> <leader>rt :retab<cr>


" e - edit file shortcuts

    nnoremap <silent> <leader>ev :e! ~/.vimrc<cr>

    nnoremap <silent> <leader>eg :e! ~/.gitconfig<cr>

    nnoremap <silent> <leader>et :term<cr>

" s - set shortcuts

    nnoremap <silent> <leader>sp :set paste!<cr>

    nnoremap <silent> <leader>sn :set relativenumber!<cr>


" l - layout shortcuts

    nnoremap <silent> <leader>ld :Goyo<CR>

    nnoremap <silent> <leader>ll :Limelight!!<CR>

    nnoremap <silent> <leader>lh <C-w>t<C-w>cv

    nnoremap <silent> <leader>lv <C-w>t<C-w>H

    " buffers
    nnoremap <silent> <leader>ln :bnext<CR>
    nnoremap <silent> <leader>lp :bprev<CR>
    nnoremap <silent> <leader>lb :buffers<CR>:buffer<Space>

" p - programming (ayy!) shortcuts


    " Python

        " Go to imported file
        nnoremap <silent> <leader>pi :Pyimport <C-R>=expand('<cWORD>')<CR><CR>

        " Switch python versions
        "nnoremap <leader>pv :call jedi#force_py_version_switch()<CR>

        "<leader>pd - go to definition
        "<leader>pg - go to assignments
        "<leader>pr - rename

" g - fuGITive commands

    nnoremap <silent> <leader>gs :Gstatus<cr>

    nnoremap <silent> <leader>ge :Gedit<cr>

    nnoremap <silent> <leader>gr :Gread<cr>

    nnoremap <silent> <leader>gb :Gblame<cr>

    nnoremap <silent> <leader>gc :Gcommit<cr>

" f - file browsing/management

    nnoremap <silent> <leader>fz :FZF<cr>

    nnoremap <silent> <leader>fn :NERDTreeToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window movement shortcuts
" move to the window in the direction shown, or create a new window
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
set splitbelow
set splitright


" Exit terminal mode
:tnoremap <Esc><Esc> <C-\><C-n>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Python-like settings for sensible editing
set tabstop=4
set shiftwidth=4
set expandtab

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    autocmd FileType cpp set shiftwidth=2 tabstop=2
    augroup END

" This has to be at the end for LeaderGuide to work
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
