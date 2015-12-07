#!/bin/bash

function opt_install() {
	read -p "Would you like to $1? (Y/N)" -n 1 -r
	echo    # (optional) move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		$2
	fi
}

function install_plugins() {
	${ENV_DIR_PATH}/tmux/tpm/bin/install_plugins
	vim +BundleInstall +qall
}

function config_git() {
	git config --global core.editor "vim"
	git config --global merge.tool "vimdiff"
	git config --global color.ui auto
	git config --global branch.autosetuprebase always
}

function set_default_zsh() {
	if [[ -x /bin/zsh ]]; then
		chsh ${LOGNAME} -s /bin/zsh
		exec /bin/zsh
	fi
}

function load_enviroment() {
	cd ~

	# Clone the repository
	git clone --recursive https://github.com/DxCx/WorkEnv .dxcx_workenv
	cd .dxcx_workenv

	# Build config for vim
	echo source `pwd`/vim/vimrc.vim > ~/.vimrc

	# Build config for tmux
	echo source-file \${ENV_DIR_PATH}/tmux/tmux.conf > ~/.tmux.conf

	# Build config for zsh
	echo export PATH=\"${PATH}\" > ~/.zshrc
	echo export ENV_DIR_PATH=`pwd` >> ~/.zshrc
	# Load ENV_DIR_PATH
	source ~/.zshrc
	# Enable zshrc config loading
	echo source \${ENV_DIR_PATH}/terminal/zshrc >> ~/.zshrc
}

# Loading initial enviorment
load_enviroment

# Install plugins
opt_install "Download and install all plugins now" install_plugins

# Config git
git config fetch.recurseSubmodules true
opt_install "Configure git" config_git

# Change zsh to default shell (Keep last)
opt_install "Use ZSH as default shell" set_default_zsh
