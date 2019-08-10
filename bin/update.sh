#!/bin/bash
cd ${ENV_DIR_PATH}
git pull --rebase
${ENV_DIR_PATH}/tmux/tpm/bin/update_plugins all
vim "+call map(dein#check_clean(), \"delete(v:val, 'rf')\")" +qall
vim "+call dein#install()" +qall
vim "+call dein#update()" +qall

nvim "+PlugUpgrade" +qall
nvim "+PlugClean" +qall
nvim "+PlugInstall" +qall
nvim "+PlugUpdate" +qall
nvim "+UpdateRemotePlugins" +qall
