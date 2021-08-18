set nocompatible

source ${ENV_DIR_PATH}/nvim/plugins.vim

" Update UI every 10ms
set updatetime=10

" Themes/Visual
" Color Scheme Solarized Dark
set termguicolors
try
colorscheme solarized-high
set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
	silent !echo "solorized-high theme is not installed yet"
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

" nvim-lspconfig + Auto Complete
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua << EOF
local lspconfig = require'lspconfig'
-- nvim-compe setup
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;
    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        treesitter = true;
        spell = true;
        tags = true;
--        ultisnips = true,
--        vsnip = false;
--        snippets_nvim = false;
    };
}
-- python language server settings (sudo pip3 install python-lsp-server[all])
lspconfig.pylsp.setup{}

-- cpp language server settings
lspconfig.clangd.setup{
    cmd = {'clangd', '--background-index', '--header-insertion=never'},
}
-- disable all lsp diagnostic virtual text to reduce noise
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
    }
)
EOF

" Treesitter configuration
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
  	  enable = true,
  	  keymaps = {
  		  goto_definition_lsp_fallback = "gd",
  		  list_definitions = "gnd",
  		  list_definitions_toc = "gO",
  		  goto_next_usage = "<a-*>",
  		  goto_previous_usage = "<a-#>",
  	  },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
EOF

" nvim-lsp mappings
" note: <C-o> go back previous pos, <C-i> forward to last pos
nnoremap <silent> gh 	<Esc>:ClangdSwitchSourceHeader<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gI    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gT   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" ################ Lsp Signature ####################
lua << EOF
require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "Search", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "shadow"   -- double, single, shadow, none
  },
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  -- deprecate !!
  -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
  zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
  debug = false, -- set to true to enable debug logging
  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black' -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
})
EOF

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
