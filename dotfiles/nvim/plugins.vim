if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" === Base tweaks ===
  " Automatic swapfile management
  Plug 'gioele/vim-autoswap'

  " Better defaults
  Plug 'tpope/vim-sensible'

  " Autodetect indentation
  Plug 'tpope/vim-sleuth'


" === Workflow ===
  " Persistent sessions
  Plug 'thaerkh/vim-workspace'
    let g:workspace_autosave = 0
    let g:workspace_autosave_always = 0

  " Two-character seek movement
  Plug 'justinmk/vim-sneak'

  " Surround.vim
  Plug 'tpope/vim-surround'

  " Git integration
  Plug 'tpope/vim-fugitive'

  " Easier commenting (gc)
  Plug 'tpope/vim-commentary'

  " Leader key hints
  Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    let g:which_key_sort_horizontal = 1
    let g:which_key_use_floating_win = 1
    let g:which_key_run_map_on_popup = 1
    let g:which_key_ignore_invalid_key = 0


" === UI ===
  " Nice start screen with recent files etc
  Plug 'mhinz/vim-startify'
  
  " Colors
  Plug 'joshdick/onedark.vim'

  " Airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme='onedark'

  " Tree file browser
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    let NERDTreeQuitOnOpen = 1
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1

  " Pretty icons
  Plug 'ryanoasis/vim-devicons'

  " Fuzzy searcher
  Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins' }

  " Git change marks in gutter
  Plug 'airblade/vim-gitgutter'


" === Highlightins ===
  Plug 'dag/vim-fish'
  Plug 'cespare/vim-toml'


" === Completions ===
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  Plug 'ervandew/supertab'
  let g:SuperTabDefaultCompletionType = "<c-n>"

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = [
  \ 'coc-lists', 
  \ 'coc-json',
  \ 'coc-vimlsp', 
  \ 'coc-rls',
  \ 'coc-python',
  \ 'coc-ultisnips'
  \ ]


" === Misc ===
  " Time tracking
  Plug 'wakatime/vim-wakatime'

  " Notes
  if !empty(glob('~/.config/nvim/vimwiki_index.vim'))
    source ~/.config/nvim/vimwiki_index.vim
  endif
  Plug 'vimwiki/vimwiki'

" === Local, in-development plugins ===
  if !empty(glob('~/.config/nvim/dev_plugins.vim'))
    source ~/.config/nvim/dev_plugins.vim
  endif

call plug#end()

" vim: set ft=vim et sw=2 ts=2 fdm=indent:
