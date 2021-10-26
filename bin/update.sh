#!/bin/zsh
cd ${ENV_DIR_PATH}
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
