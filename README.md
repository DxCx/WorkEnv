MyVimRc
=======
my vim configurations and plugins

You should checkout the folder wherever you like:
Windows :
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

    sudo apt-get install zsh git-core build-essential vim-gtk curl python-pip

Arch :
----------

    sudo pacman -S yaourt zsh pep8-python2 python2-pylint ipython2 gvim curl python2-pip base-devel git

Linux :
----------

    cd ~
    git clone --recursive https://github.com/DxCx/WorkEnv .dxcx_workenv
    cd .dxcx_workenv
    echo source `pwd`/vim/vimrc.vim > ~/.vimrc
    cp `pwd`/tmux/base_tmux.conf ~/.tmux.conf
    echo export PATH=\"${PATH}\" > ~/.zshrc
    echo export ENV_DIR_PATH=`pwd` >> ~/.zshrc
    echo source \${ENV_DIR_PATH}/terminal/zshrc >> ~/.zshrc
    `pwd`/tmux/tpm/bin/install_plugins
    git config --global core.editor "vim"
    git config --global merge.tool "vimdiff"
    git config --global color.ui auto
    git config --global branch.autosetuprebase always
    chsh ${LOGNAME} -s /bin/zsh

Powerline fonts:
-----------------
    pushd ~/.dxcx_workenv/terminal/powerline-fonts
    find -type d -not -iwholename '*.git*' -exec sudo cp -Rf {} /usr/share/fonts/ \;
    popd
    sudo fc-cache -vf

Solorized XFCE4 shell:
------------------
    pushd ~/.dxcx_workenv/terminal/xfce4-terminal-colors-solarized
    cp dark/terminalrc ~/.config/xfce4/terminal/terminalrc
    popd

To update all plugins:
----------------
    git submodule foreach 'git remote update origin; git fetch origin; git checkout $(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'
