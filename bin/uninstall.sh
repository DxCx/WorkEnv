#!/bin/bash

set -e

cd ~

if [ ! -d "${ENV_DIR_PATH}" ]; then
	echo "ENV_DIR_PATH (${ENV_DIR_PATH}) does not exists"
	exit
fi

echo "Uninstalling... (${ENV_DIR_PATH})"
rm -f ~/.vimrc
rm -f ~/.tmux.conf
rm -f ~/.zshrc
rm -f ~/.config/xfce4/terminal/terminalrc
rm -f ~/.fonts/PowerlineSymbols.otf
rm -f ~/.config/fontconfig/conf.d/10-powerline-symbols.conf 
fc-cache -vf ~/.fonts
rm -Rf ${ENV_DIR_PATH}

chsh -s /bin/bash
exec /bin/bash
