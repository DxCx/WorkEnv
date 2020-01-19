#!/bin/bash
cd ${ENV_DIR_PATH}
git pull --rebase
${ENV_DIR_PATH}/tmux/tpm/bin/update_plugins all

nvim "+PlugUpgrade" +qall
nvim "+PlugClean" +qall
nvim "+PlugInstall" +qall
nvim "+PlugUpdate" +qall
nvim "+UpdateRemotePlugins" +qall
