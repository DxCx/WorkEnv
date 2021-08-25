let plugins_dir=eval('$ENV_DIR_PATH') . '/nvim/plugins'
source ${ENV_DIR_PATH}/nvim/plug/plug.vim

call plug#begin(plugins_dir)

" Welcome screen
Plug 'mhinz/vim-startify'

" Git Plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" EasyMotion (Go to word X)
Plug 'easymotion/vim-easymotion'

" Airline (status-line)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" OceanicNext theme
Plug 'mhartington/oceanic-next'

" HexMode
Plug 'fidian/hexmode'

" Mundo (Gundo fork for nvim)
Plug 'simnalamburt/vim-mundo'

" nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

" Trim Whitespaces
Plug 'derekprior/vim-trimmer'

" Maximizer (Zoom)
Plug 'szw/vim-maximizer'

" TODO: Snippets?

" Project files support (.vimprj)
Plug 'vim-scripts/DfrankUtil'
Plug 'vim-scripts/vimprj'

" AutoFromat
Plug 'rhysd/vim-clang-format'

" Lsp signature
Plug 'ray-x/lsp_signature.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" AutoCompletion
Plug 'neovim/nvim-lspconfig'
Plug 'haorenW1025/completion-nvim'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'steelsojka/completion-buffers'

" Multi-entry selection UI. (Ctrl+p)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" FileTypes
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'vivien/vim-linux-coding-style', { 'for': ['cpp', 'c'] }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
" A - for switching between source and header files
Plug 'vim-scripts/a.vim', { 'for': ['cpp', 'c'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
" CMake Support
Plug 'vhdirk/vim-cmake'

" GDB
Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }

call plug#end()
