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

" Solarized theme
Plug 'iCyMind/NeoSolarized'

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

" AutoCompletion
" For async completion
"Plug 'Shougo/deoplete.nvim'
" For Denite features
"Plug 'Shougo/denite.nvim'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-github'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Multi-entry selection UI. (Ctrl+p)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" FileTypes
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'vivien/vim-linux-coding-style', { 'for': ['cpp', 'c'] }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
" A - for switching between source and header files
Plug 'vim-scripts/a.vim', { 'for': ['cpp', 'c'] }
Plug 'mhartington/nvim-typescript', {'for': 'typescript', 'do': './install.sh'}
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
" CMake Support
Plug 'vhdirk/vim-cmake'

" GDB
Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }

call plug#end()
