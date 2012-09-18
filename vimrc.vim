" first set runtimepath to this directory.
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')

" Setup Pathogen
runtime pathogen\autoload\pathogen.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" set filetype stuff on
filetype on
filetype plugin on

" Color Scheme Desert (Changed BG to black)
colorscheme dxcx_desert

" Forget being compatible with good ol' vi
" and enable hidden buffers support
set nocompatible
set hidden

" Ident settings
filetype indent on
set tabstop=4
set shiftwidth=4
set autoindent  " always auto indent
set copyindent  " copy indent from privius line
set smarttab    " insert tabs according to shiftwidth

" No ~ or swap files.
set nobackup
set noswapfile

" Show Line numbers
set nu

" set the search scan to wrap lines
" and ignore case, but recognize upper case
set wrapscan
set ignorecase
set smartcase

" User FWSlash and now backslash
set shellslash


" add $ at the end of replace instead of just delete it.
set cpoptions=ces$

" AutoComplete Setup:
" . = current buffer
" w = buffers from other windows
" b = buffers loaded in the buffer list
" k = files from the directory
" d = include defines 
" i = includes
" tag complition
set complete=.,w,b,k,d,i,t

" Cool complete menu
set wildmenu

" Search options (search as you type + highlight)
set hlsearch
set incsearch

" I Want vim to remember as much as he can
set history=1000
set undolevels=1000

" don't autocomplete to match those file types 
set wildignore=*.swp,*.bak,*.pyc,*.class

" I Want leader key to be , and not \
let mapleader=","

" Python spcific settings
autocmd filetype python set expandtab   " Use spaces and not real tabs

" custom Bindings
map <F2> :NERDTreeToggle<CR>
