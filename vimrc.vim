" Use FWSlash instead of backslash
set shellslash

" first set runtimepath to this directory.
let &runtimepath.=','.escape(expand('<sfile>:p:h'), '\,')

" My ctags settings
let ctags_on="no"
let ctags_exe=expand('<sfile>:p:h')."\/ctags.exe"
let ctags_file="tags"
let ctags_options="--c++-kinds=+p --fields=+iaS --extra=+q --extra=+f"

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

function! UpdateCTags()
	if g:ctags_on == "yes"
		let l:opts = g:ctags_options." -f ".g:ctags_file
		if filereadable(g:ctags_file)
			execute "silent! !".g:ctags_exe." ".l:opts."\"".expand("%:p")."\""
		else
			" Create new file
			execute "silent! !".g:ctags_exe." ".l:opts." -R * &"
		endif
	endif
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

" Auto create ctags with AU
au BufWritePost *.c,*.cpp,*.h :call UpdateCTags()

" Enable syntax highlight
syntax on

" Python & Html Autocomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Setup syntax checker
"let g:syntastic_python_checkers=['pylint', 'pep8']
let g:syntastic_cpp_check_header = 1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
