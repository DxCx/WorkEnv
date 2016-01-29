#!/bin/bash
cd ${ENV_DIR_PATH}
git pull --rebase
${ENV_DIR_PATH}/tmux/tpm/bin/update_plugins all
vim +BundleUpdate +qall
