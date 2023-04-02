#!/bin/zsh
source ${ENV_DIR_PATH}/terminal/antigen/antigen.zsh
source ${ENV_DIR_PATH}/terminal/aliases

cd ${ENV_DIR_PATH}

pushd appimages
./update.sh
popd

git pull --rebase
antigen reset
antigen update
${ENV_DIR_PATH}/tmux/tpm/bin/update_plugins all

nvim "+PlugUpgrade" +qall
nvim "+PlugClean" +qall
nvim "+PlugInstall" +qall
nvim "+PlugUpdate" +qall
nvim "+UpdateRemotePlugins" +qall
# Treesitter update
nvim "+TSUpdate" +qall

# Make sure everything is in place
nvim "+checkhealth"
