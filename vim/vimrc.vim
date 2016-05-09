" Use FWSlash instead of backslash
set shellslash

" first set runtimepath to this directory.
let &runtimepath.=','.eval('$ENV_DIR_PATH') . '/vim/dein/repos/github.com/Shougo/dein.vim'

" Setup dein for Plugins
set nocompatible
call dein#begin(eval('$ENV_DIR_PATH') . '/vim/dein')
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
if !empty(glob(eval('$ENV_DIR_PATH') . '/vim/dein/repos/github.com/Shougo/vimproc.vim'))
" --------------------------------------

call dein#add('Shougo/vimshell.vim')
call dein#add('vim-scripts/DirDiff.vim.git')
call dein#add('bling/vim-airline.git')
call dein#add('kien/ctrlp.vim.git')
call dein#add('derekwyatt/vim-fswitch.git')
call dein#add('tpope/vim-fugitive')
call dein#add('sjl/gundo.vim')
call dein#add('wikitopian/hardmode.git')
call dein#add('scrooloose/nerdcommenter.git')
call dein#add('scrooloose/nerdtree')
call dein#add('amix/open_file_under_cursor.vim.git')
call dein#add('derekwyatt/vim-protodef')
call dein#add('altercation/vim-colors-solarized.git')
call dein#add('bingaman/vim-sparkup.git')
call dein#add('scrooloose/syntastic.git')
call dein#add('godlygeek/tabular')
call dein#add('tmux-plugins/vim-tmux-focus-events.git')
call dein#add('sophacles/vim-bundle-mako.git')
call dein#add('Lokaltog/vim-easymotion.git')
call dein#add('airblade/vim-gitgutter.git')
call dein#add('xolox/vim-misc.git')
call dein#add('drmingdrmer/xptemplate.git')

" File types plugins
call dein#add('leafgarland/typescript-vim.git', { 'on_ft': 'ts' })
call dein#add('kchmck/vim-coffee-script.git', { 'on_ft': 'coffee' })
call dein#add('othree/html5-syntax.vim', { 'on_ft': 'html' })
call dein#add('davidhalter/jedi-vim.git', { 'on_ft': 'py' })

" Test it later
call dein#add('Shougo/neocomplete.vim')

" --------------------------------------
endif
call dein#end()

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

" NeoComplete Configuration
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
