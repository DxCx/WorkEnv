MyVimRc
=======
my vim configurations and plugins

You should checkout the folder wherever you like:
Windows :
----------
using TortoiseGit just Clone the repo
then don't forget to do:

    Right Click > TortoiseGit > Submodule Update

Linux :
----------

    git clone https://github.com/DxCx/MyVimRc vim_config
    cd vim_config
    git submodule init
    git submodule update --recursive

And Then :
----------
After the repository is created don't forget to
source the vimrc inside the original .vimrc:

    source X:\vim_config\vimrc.vim
