#!/bin/bash

set -e
MAC_MODE=false

if which brew &> /dev/null; then
	MAC_MODE=true
fi

cd ~

if [ ! -d "${ENV_DIR_PATH}" ]; then
	echo "ENV_DIR_PATH (${ENV_DIR_PATH}) does not exists"
	exit
fi

echo "Uninstalling... (${ENV_DIR_PATH})"
rm -f ~/.config/nvim/init.vim
rm -f ~/.vimrc
rm -f ~/.tmux.conf
rm -f ~/.zshrc
if [[ ${MAC_MODE} = false ]]; then
	rm -f ~/.i3
	rm -f ~/.config/xfce4/terminal/terminalrc
	rm -f ~/.fonts/PowerlineSymbols.otf
	rm -f ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
	fc-cache -vf ~/.fonts
else
    rm -f ~/Library/Preferences/com.googlecode.iterm2.plist
	rm -f ~/Library/Fonts/*Powerline*.otf
fi
rm -Rf ${ENV_DIR_PATH}

chsh -s /bin/bash
exec /bin/bash
