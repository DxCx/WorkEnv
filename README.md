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

    sudo pacman -S yaourt zsh pep8-python2 python2-pylint ipython2 gvim curl pip2 base-devel git

Linux :
----------

    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
    cd ~
    git clone https://github.com/DxCx/MyVimRc .vim_config
    cd .vim_config
    git submodule init
    git submodule update --recursive
    echo source ~/.vim_config/vimrc.vim > ~/.vimrc
    git config --global core.editor "vim"
    git config --global merge.tool "vimdiff"
    chsh ${LOGNAME} -s /bin/zsh
    
