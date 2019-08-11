set nocompatible

source ${ENV_DIR_PATH}/nvim/plugins.vim

" Update UI every 10ms
set updatetime=10

" Themes/Visual
" Color Scheme Solarized Dark
set termguicolors
try
colorscheme NeoSolarized
set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
	silent !echo "NeoSolorized theme is not installed yet"
endtry

" Mouse Cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
			\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
			\,sm:block-blinkwait175-blinkoff150-blinkon175

" Status Bar (Airline)
set laststatus=2
set t_Co=256 " 256 Colors!
let g:airline_powerline_fonts=1
let g:airline_theme='murmur'
let g:airline_section_x=""
let g:airline_section_y="%{strlen(&ft)?&ft:'none'}:%{&ff}"
let g:airline_right_sep=''

" Show Line numbers
set nu
" Enable relative number to the line
set relativenumber

" Fugitive's Autocmd to clean uneeded buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" ----------------------- General VIM Configuration ----------------------------
" set filetype stuff on
filetype on
filetype plugin on
filetype plugin indent on
" Enable syntax highlight
syntax enable
" Ident settings
filetype indent on
set noexpandtab
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set autoindent  " always auto indent
set copyindent  " copy indent from privius line
set smarttab    " insert tabs according to shiftwidth
" set the search scan to wrap lines
" and ignore case, but recognize upper case
set wrap
set linebreak
set nolist
set wrapscan
set ignorecase
set smartcase
set backspace=indent,eol,start

" Search options (search as you type + highlight)
set hlsearch
set incsearch
set inccommand=nosplit

" I Want vim to remember as much as he can
set history=1000
set undolevels=1000

" don't autocomplete to match those file types
set wildignore=*.swp,*.bak,*.pyc,*.class

" enable hidden buffers support
set hidden

" No ~ or swap files.
set nobackup
set noswapfile

" Set region to English
set spelllang=en_us

" -------------------------- Key Bindings -----------------------------
" I Want leader key to be , and not \
let mapleader=","

" Spellchecker toggler
nmap <silent> <leader>s :set spell!<CR>

" remove Trailing spaces on ,<space>
nmap <silent> <leader><space> mzgg=G`z<CR>:w<CR>:%s/\\s\\+$//g<CR>:w<CR>

" NERDTree
map  <silent> <F2> :NERDTreeToggle<CR>

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

" Relative numbering toggler
map <silent> - :set relativenumber!<CR>

" Mapping F8 to change to Hex View
noremap <F8> :call Hexmode()<CR>

" Ctrl+P to fzf
nnoremap <C-p> :GFiles<Cr>

" NCM (nvim-complete-manager)
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" NCM (nvim-complete-manager)
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" File types
let g:LanguageClient_cppServer = ['clangd', '-background-index']
function ReconfigureLangugeClient()
	let g:LanguageClient_serverCommands = {
				\ 'cpp': g:LanguageClient_cppServer,
				\ 'c': g:LanguageClient_cppServer,
				\ 'python': ['/usr/local/bin/pyls'],
				\ }

	try
		execute 'LanguageClientStop'
		execute 'LanguageClientStart'
	catch
	endtry
endfunction
call ReconfigureLangugeClient()

" ################ Clang format #####################

" Clang format - auto formatting

let g:clang_format#command = 'clang-format'
let g:clang_format#detect_style_file = 1

" shortcuts for autoformatting the entire file: Ctrl+j
inoremap <C-j> <Esc>:ClangFormat<CR>a
nnoremap <C-j> <Esc>:ClangFormat<CR>

" autocmd FileType c ClangFormatAutoEnable
" autocmd FileType cpp ClangFormatAutoEnable

" Fix Termmode cursor
:hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" Termmode bindings
tnoremap <C-[> <C-\><C-n>
tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Maximizer
let g:maximizer_set_default_mapping = 1
let g:maximizer_set_mapping_with_bang = 0
let g:maximizer_default_mapping_key = '<C-w>z'
