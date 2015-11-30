WorkEnv
=======
my vim configurations and plugins

You should checkout the folder wherever you like:
Windows (Vim Only):
----------
using TortoiseGit just Clone the repo
then don't forget to do:

    Right Click > TortoiseGit > Submodule Update

After the repository is created don't forget to
source the vimrc inside the original .vimrc:

    source X:\dxcx_workenv\vim\vimrc.vim

Python:

    http://downloads.activestate.com/ActivePython/releases/2.7.2.5/ActivePython-2.7.2.5-win32-x86.msi
    http://www.lfd.uci.edu/~gohlke/pythonlibs/2jdj6mdn/pip-1.4.1.win32-py2.7.exe

Finally:

    pip install ipython pyreadline

Ubuntu :
----------

    sudo apt-get install zsh git-core build-essential vim-gtk curl python-pip xclip

Arch :
----------

    sudo pacman -S yaourt zsh pep8-python2 python2-pylint ipython2 gvim curl python2-pip base-devel git xclip

Linux :
----------

    cd ~
    git clone --recursive https://github.com/DxCx/WorkEnv .dxcx_workenv
    cd .dxcx_workenv
    echo source `pwd`/vim/vimrc.vim > ~/.vimrc
    echo source-file \${ENV_DIR_PATH}/tmux/tmux.conf > ~/.tmux.conf
    echo export PATH=\"${PATH}\" > ~/.zshrc
    echo export ENV_DIR_PATH=`pwd` >> ~/.zshrc
    source ~/.zshrc
    echo source \${ENV_DIR_PATH}/terminal/zshrc >> ~/.zshrc
    ${ENV_DIR_PATH}/tmux/tpm/bin/install_plugins
    vim +BundleInstall +qall
    git config --global core.editor "vim"
    git config --global merge.tool "vimdiff"
    git config --global color.ui auto
    git config --global branch.autosetuprebase always
    chsh ${LOGNAME} -s /bin/zsh

Powerline fonts (System Wide):
-----------------
    pushd ~/.dxcx_workenv/terminal/powerline-fonts
    find -type d -not -iwholename '*.git*' -exec sudo cp -Rf {} /usr/share/fonts/ \;
    popd
    sudo fc-cache -vf

Powerline fonts (Single User):
------------------
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
    fc-cache -vf ~/.fonts
    mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

Solarized XFCE4 shell:
------------------
    pushd ~/.dxcx_workenv/terminal/xfce4-terminal-colors-solarized
    cp dark/terminalrc ~/.config/xfce4/terminal/terminalrc
    popd

To update all plugins:
----------------
    git submodule foreach 'git remote update origin; git fetch origin; git checkout $(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'
