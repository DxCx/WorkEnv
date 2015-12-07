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
Easy Install script attached.
#### via curl

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/DxCx/WorkEnv/master/install.sh)"
```

#### via wget

```shell
bash -c "$(wget https://raw.githubusercontent.com/DxCx/WorkEnv/master/install.sh -O -)"
```

Powerline fonts (System Wide):
-----------------
    cd ~
    git clone https://github.com/Lokaltog/powerline-fonts
    cd powerline-fonts
    find -type d -not -iwholename '*.git*' -exec sudo mv {} /usr/share/fonts/ \;
    cd ..
    rm -Rf powerline-fonts
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
