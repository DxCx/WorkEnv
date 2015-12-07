#!/bin/bash

cd ~

# Clone the repository
git clone --recursive https://github.com/DxCx/WorkEnv .dxcx_workenv
cd .dxcx_workenv

# Build configuration files
echo source `pwd`/vim/vimrc.vim > ~/.vimrc
echo source-file \${ENV_DIR_PATH}/tmux/tmux.conf > ~/.tmux.conf
echo export PATH=\"${PATH}\" > ~/.zshrc
echo export ENV_DIR_PATH=`pwd` >> ~/.zshrc

# Load ENV_DIR_PATH
source ~/.zshrc
# Enable zshrc config loading
echo source \${ENV_DIR_PATH}/terminal/zshrc >> ~/.zshrc

# Install plugins
${ENV_DIR_PATH}/tmux/tpm/bin/install_plugins
vim +BundleInstall +qall

# Config git
git config fetch.recurseSubmodules true
git config --global core.editor "vim"
git config --global merge.tool "vimdiff"
git config --global color.ui auto
git config --global branch.autosetuprebase always

# Change zsh to default shell
chsh ${LOGNAME} -s /bin/zsh

exec /bin/zsh
