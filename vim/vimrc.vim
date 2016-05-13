" --------------------- Setup vim Plugins ----------------------
" Use FWSlash instead of backslash
set shellslash

" Forget being compatible with good old vi
set nocompatible

" first set runtimepath to this directory.
let &runtimepath.=','.eval('$ENV_DIR_PATH') . '/vim/dein/repos/github.com/Shougo/dein.vim'

" Setup dein for Plugins
call dein#begin(eval('$ENV_DIR_PATH') . '/vim/dein')
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

" Make sure vimproc will be installed first
if dein#check_install(['vimproc.vim'])
	call dein#install()
endif

" --------------------------------------

" Shougo packages
call dein#add('Shougo/vimshell.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neoinclude.vim')
call dein#add('Shougo/neocomplete.vim')

" Themes
call dein#add('bling/vim-airline.git')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('altercation/vim-colors-solarized.git')

" Misc
call dein#add('xolox/vim-misc.git')
call dein#add('takac/vim-hardtime')
call dein#add('vim-scripts/DirDiff.vim.git')
call dein#add('sjl/gundo.vim')
call dein#add('easymotion/vim-easymotion')
call dein#add('fidian/hexmode')
call dein#add('scrooloose/nerdtree')

" Git support
call dein#add('tmux-plugins/vim-tmux-focus-events.git')
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter.git')

" File Nevigation
call dein#add('amix/open_file_under_cursor.vim.git')

" File types plugins
call dein#add('scrooloose/syntastic.git')
call dein#add('mhartington/vim-typings', { 'on_ft': 'typescript' })
call dein#add('leafgarland/typescript-vim.git', { 'on_ft': 'typescript' })
call dein#add('Quramy/tsuquyomi', { 'on_ft': 'typescript' })
call dein#add('kchmck/vim-coffee-script.git', { 'on_ft': 'coffee' })
call dein#add('othree/html5-syntax.vim', { 'on_ft': 'html' })
call dein#add('davidhalter/jedi-vim.git', { 'on_ft': 'python' })

" Junkyard - Old Plugins to cleanup
" call dein#add('drmingdrmer/xptemplate.git')
" call dein#add('godlygeek/tabular')
" call dein#add('bingaman/vim-sparkup.git')

" --------------------------------------
call dein#end()

" ----------------------- General VIM Configuration ----------------------------
" set filetype stuff on
filetype on
filetype plugin on
filetype plugin indent on
" Enable syntax highlight
syntax enable
" Ident settings
filetype indent on
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

" Themes/Visual
" Color Scheme Solarized Dark
let g:solarized_termcolors=256
if dein#is_sourced('vim-colors-solarized')
colorscheme solarized
set background=dark
endif
" Show Line numbers
set nu
" Enable relative number to the line
set relativenumber

" ----------------------- Plugins Configuration ------------------------------
" Unite
if dein#is_sourced('unite')
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'
if executable('ag')
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
\ '-i --vimgrep --hidden --ignore ' .
\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''
endif
endif

" Fugitive's Autocmd to clean uneeded buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Status Bar (Airline)
set laststatus=2
set t_Co=256 " 256 Colors!
let g:airline_powerline_fonts=1
let g:airline_theme='murmur'
let g:airline_section_x=""
let g:airline_section_y="%{strlen(&ft)?&ft:'none'}:%{&ff}"
let g:airline_right_sep=''

" NeoComplete
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

" Hardtime
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1
let g:hardtime_maxcount = 2

" -------------------------- Key Bindings -----------------------------
" I Want leader key to be , and not \
let mapleader=","

" Spellchecker toggler
nmap <silent> <leader>s :set spell!<CR>

" remove Trailing spaces on ,<space>
nmap <silent> <leader><space> mzgg=G`z<CR>:w<CR>:%s/\\s\\+$//g<CR>:w<CR>

" Unite
nnoremap <silent> <C-p> :Unite -auto-resize -start-insert file file_mru file_rec/async<CR>
nnoremap <silent> <C-g> :Unite -auto-preview grep:.<cr>

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

" NeoComplete
inoremap <expr> <C-g>     neocomplete#undo_completion()
inoremap <expr> <C-l>     neocomplete#complete_common_string()
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr> <C-h> neocomplete#smart_close_popup()
inoremap <expr> <BS> neocomplete#smart_close_popup()."\<C-h>"

" ----------------------- File types settings -------------------------
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" C/C++
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" Python
autocmd FileType python set expandtab   " Use spaces and not real tabs
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" CoffeeScript
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" CSS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS

" HTML
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

" Javascript
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" Typescript
let g:neocomplete#sources#omni#input_patterns.typescript = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType typescript nnoremap <silent> <leader>t :Unite -auto-resize -start-insert typings<cr>

" XML
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" --------------------- Keep Last -------------------------------
" Allow overrides via ~/.vim/vimrc.local
if filereadable(expand("~/.vim/vimrc.local"))
    source ~/.vim/vimrc.local
endif
