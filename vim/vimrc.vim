" Use FWSlash instead of backslash
set shellslash

" first set runtimepath to this directory.
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')

" Setup Vundle
exec 'set rtp+=' . expand('${ENV_DIR_PATH}/vim/bundle/Vundle.vim')
call vundle#begin(eval('$ENV_DIR_PATH') . '/vim/bundle')

" Plugins
Plugin 'VundleVim/Vundle.vim'
" --------------------------------------

Plugin 'vim-scripts/DirDiff.vim.git'
Plugin 'bling/vim-airline.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'derekwyatt/vim-fswitch.git'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim'
Plugin 'wikitopian/hardmode.git'
Plugin 'othree/html5-syntax.vim'
Plugin 'davidhalter/jedi-vim.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/nerdtree'
Plugin 'amix/open_file_under_cursor.vim.git'
Plugin 'derekwyatt/vim-protodef'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'bingaman/vim-sparkup.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'godlygeek/tabular'
Plugin 'tmux-plugins/vim-tmux-focus-events.git'
Plugin 'sophacles/vim-bundle-mako.git'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'Lokaltog/vim-easymotion.git'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'xolox/vim-misc.git'
Plugin 'tmux-plugins/vim-tmux.git'
Plugin 'drmingdrmer/xptemplate.git'

" Keep last, end of plugins
call vundle#end()
" --------------------------------------

" set filetype stuff on
filetype on
filetype plugin on
filetype plugin indent on

" Enable syntax highlight
syntax enable

" Color Scheme Solarized Dark
let g:solarized_termcolors=256
try
    colorscheme solarized
    set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
	silent !echo "Solorized theme is not installed yet"
endtry

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

" Python specific settings
autocmd filetype python set expandtab   " Use spaces and not real tabs
" coffee specific settings
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

function! CmdRun(str)
	exe a:str
endfunction

let my_grep_base="."

function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

function! GrepCursor()
	exe "normal! viw"
	call VisualSelection("vimgrep")
endfunction

function! VisualSelection(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'vimgrep'
		" call CmdLine("vimgrep " . '/'. l:pattern . '/ ' . g:my_grep_base . '/**/*.[ch]')
		call CmdRun("vimgrep " . '/'. l:pattern . '/ ' . g:my_grep_base . '/**/*.[ch]')
		exe "ccl"
		exe "cwindow"
	elseif a:direction == 'replace'
		call CmdLine("%s" . '/'. l:pattern . '/')
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

" custom Bindings
map  <silent> <F2> :NERDTreeToggle<CR>
vmap <silent> <leader>g :call VisualSelection('vimgrep')<CR>
nmap <silent> <leader>g :call GrepCursor()<CR>
nmap <silent> <leader>s :set spell!<CR>

" Switch to alternate file
nmap <silent> <F5> :make<CR>
nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>

" Fugitive's Autocmds.
autocmd BufReadPost fugitive://* set bufhidden=delete

" remove Trailing spaces on ,<space>
nmap <silent> <leader><space> mzgg=G`z<CR>:w<CR>:%s/\\s\\+$//g<CR>:w<CR>

" Set xptemplate to more convinent key
let g:xptemplate_key = '<Tab>'

" Status Bar
set laststatus=2
set t_Co=256 " 256 Colors!
let g:airline_powerline_fonts=1
let g:airline_theme='murmur'
let g:airline_section_x=""
let g:airline_section_y="%{strlen(&ft)?&ft:'none'}:%{&ff}"
let g:airline_right_sep=''

" Allow overrides via ~/.vim/vimrc.local
if filereadable(expand("~/.vim/vimrc.local"))
    source ~/.vim/vimrc.local
endif

" CtrlP
nmap <silent> <leader>f :CtrlP<CR>

" Mako template syntax:
au BufNewFile,BufRead *.tmpl set filetype=mako

" EasyMotion
let g:EasyMotion_do_mapping=0
map w <Plug>(easymotion-w)
map W <Plug>(easymotion-W)
map e <Plug>(easymotion-e)
map E <Plug>(easymotion-E)
map b <Plug>(easymotion-b)
map B <Plug>(easymotion-B)
" map f <Plug>(easymotion-f)
" map F <Plug>(easymotion-F)
" map t <Plug>(easymotion-t)
" map T <Plug>(easymotion-T)

" Gundo Mapping
map <silent> <F3> :GundoToggle<CR>

" Relative numbering
set relativenumber
map <silent> - :set relativenumber!<CR>

" Mapping F8 to change to Hex View
noremap <F8> :call HexMe()<CR>

let $in_hex=0
function HexMe()
	set binary
	set noeol
	if $in_hex>0
		:%!xxd -r
		let $in_hex=0
	else
		:%!xxd
		let $in_hex=1
	endif
endfunction

" Enable Hardmode :) (Disabled at the moment until relative will work)
" Until issue resolve, No arrow keys
map   <Up>     <NOP>
map   <Down>   <NOP>
map   <Left>   <NOP>
map   <Right>  <NOP>
imap   <Up>     <NOP>
imap   <Down>   <NOP>
imap   <Left>   <NOP>
imap   <Right>  <NOP>
vmap   <Up>     <NOP>
vmap   <Down>   <NOP>
vmap   <Left>   <NOP>
vmap   <Right>  <NOP>
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
