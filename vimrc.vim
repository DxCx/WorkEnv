" first set runtimepath to this directory.
let &runtimepath.=','.escape(expand('%:p:h'), '\,')

" Setup Pathogen
source pathogen\autoload\pathogen.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Color Scheme Desert (Changed BG to black)
colorscheme dxcx_desert

" Forget being compatible with good ol' vi
" and enable hidden buffers support
set nocompatible
set hidden

" Tab/Shift stop
set tabstop=4
set shiftwidth=4

" No ~ Files.
set nobackup

" Show Line numbers
set nu

" set the search scan to wrap lines
" and ignore case, but recognize upper case
set wrapscan
set ignorecase
set smartcase

" User FWSlash and now backslash
set shellslash

" set filetype stuff on
filetype on
filetype plugin on
filetype indent on

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
