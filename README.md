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

    source X:\vim_config\vimrc.vim

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

    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
    cd ~
    git clone --recursive https://github.com/DxCx/MyVimRc .vim_config
    cd .vim_config
    echo source ~/.vim_config/vimrc.vim > ~/.vimrc
    git config --global core.editor "vim"
    git config --global merge.tool "vimdiff"
    git config --global color.ui auto
    git config --global branch.autosetuprebase always
    chsh ${LOGNAME} -s /bin/zsh
    ln -s ${HOME}/.vim_config/tmux.conf ${HOME}/.tmux.conf

Powerline fonts:
-----------------
    cd ~
    git clone https://github.com/Lokaltog/powerline-fonts
    cd powerline-fonts
    find -type d -not -iwholename '*.git*' -exec sudo mv {} /usr/share/fonts/ \;
    cd ..
    rm -Rf powerline-fonts
    sudo fc-cache -vf

To update all plugins:
----------------
    git submodule foreach 'git remote update origin; git fetch origin; git checkout $(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'
