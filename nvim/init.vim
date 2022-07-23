set nocompatible

source ${ENV_DIR_PATH}/nvim/plugins.vim

" Update UI every 10ms
set updatetime=10

" Themes/Visual
" Color Scheme Solarized Dark
set termguicolors
if (has("termguicolors"))
  set termguicolors
endif
try
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme OceanicNext
set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
	silent !echo "OceanicNext theme is not installed yet"
endtry

" Mouse Cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
			\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
			\,sm:block-blinkwait175-blinkoff150-blinkon175

" Status Bar (Airline)
set laststatus=2
set t_Co=256 " 256 Colors!
let g:airline_powerline_fonts=1
let g:airline_theme='oceanicnext'
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

" Telescope Config
lua << EOF
require('telescope').setup {
  pickers = {
    -- Your special builtin config goes in here
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = true,
    },
    git_files = {
    	show_untracked = false,
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF

" Ctrl+P to fzf
nnoremap <C-p> :Telescope git_files<Cr>

" nvim-lspconfig + Auto Complete
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'nvim_lsp' },
	  { name = 'treesitter' },
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local lspconf_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  lspconf_capabilities.textDocument.completion.completionItem.snippetSupport = true
  lspconf_capabilities.textDocument.completion.completionItem.resolveSupport = {
	  properties = { "documentation", "detail", "additionalTextEdits" },
  }
EOF

lua << EOF
local lspconfig = require'lspconfig'
-- python language server settings (sudo pip3 install python-lsp-server[all])
lspconfig.pylsp.setup{
    capabilities = lspconf_capabilities,
}

-- vim ls
lspconfig.vimls.setup{
    capabilities = lspconf_capabilities,
}

-- typescript ls
lspconfig.tsserver.setup{
    capabilities = lspconf_capabilities,
}

-- cpp language server settings
--lspconfig.ccls.setup{
--    capabilities = lspconf_capabilities,
--}
lspconfig.clangd.setup{
    cmd = {'clangd', '--background-index', '--header-insertion=iwyu', "--clang-tidy", "--cross-file-rename", "--completion-style=bundled"},
    capabilities = lspconf_capabilities,
    init_options = {
    clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
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
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
