" Use FWSlash instead of backslash
set shellslash

" first set runtimepath to this directory.
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')

" Setup Pathogen
runtime pathogen/autoload/pathogen.vim
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
set wrap
set linebreak
set nolist
set wrapscan
set ignorecase
set smartcase

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

" Set region to English
set spelllang=en_us

" Python spcific settings
autocmd filetype python set expandtab   " Use spaces and not real tabs

" custom Bindings
map  <silent> <F2> :NERDTreeToggle<CR>
nmap <silent> <leader>s :set spell!<CR>
map <silent> <leader>g <Esc>:Ack!<CR>

" Switch to alternate file
nmap <silent> <F5> :make<CR>
nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>

" Enable syntax highlight
syntax on

" Setup syntax checker
let g:syntastic_cpp_check_header = 1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" Completion
setlocal completeopt-=preview
let g:jedi#completions_command = "<C-p>"
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
