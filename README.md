WorkEnv
=======
my work enviorment configurations and plugins

Windows (Vim Only):
----------
using TortoiseGit just Clone the repo
then don't forget to do:
```shell
Right Click > TortoiseGit > Submodule Update
```

After the repository is created don't forget to
source the vimrc inside the original .vimrc:
```shell
source X:\dxcx_workenv\vim\vimrc.vim
```

Python:
```shell
http://downloads.activestate.com/ActivePython/releases/2.7.2.5/ActivePython-2.7.2.5-win32-x86.msi
http://www.lfd.uci.edu/~gohlke/pythonlibs/2jdj6mdn/pip-1.4.1.win32-py2.7.exe
```

Finally:
```shell
pip install ipython pyreadline
```

Linux :
----------
Easy Install script attached, To skip the installation prompts (Assumes all yes) use NOCONFIRM=1 before the bash command.
#### via curl

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/DxCx/WorkEnv/master/bin/install.sh)"
```

#### via wget

```shell
bash -c "$(wget https://raw.githubusercontent.com/DxCx/WorkEnv/master/bin/install.sh -O -)"
```

Powerline fonts (System Wide):
-----------------
```shell
cd ~
git clone https://github.com/Lokaltog/powerline-fonts
cd powerline-fonts
find -type d -not -iwholename '*.git*' -exec sudo mv {} /usr/share/fonts/ \;
cd ..
rm -Rf powerline-fonts
sudo fc-cache -vf
```

To update all plugins:
----------------
```shell
git submodule foreach 'git remote update origin; git fetch origin; git checkout $(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'
```
