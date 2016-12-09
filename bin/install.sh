#!/bin/bash

NOCONFIRM=${NOCONFIRM:-0}
DEBIAN_DEPENDS=(zsh git-core build-essential vim curl python-pip tmux wget gettext-base rsync silversearcher-ag dmenu)
BREW_DEPENDS=(zsh git vim curl tmux wget gettext rsync the_silver_searcher)
RH_DEPENDS=(zsh git-all make automake gcc gcc-c++ vim-full curl python-pip xclip tmux wget rsync dmenu)
ARCH_DEPENDS=(yaourt zsh python2-autopep8 python2-pylint ipython2 gvim curl python2-pip base-devel git xclip tmux wget rsync the_silver_searcher dmenu xorg-xkill)
MAC_MODE=false

function opt_oper() {
	# Read question and shift arguments ($2 = $1)
	question=$1
	shift
	# Read default_val and shift arguments ($2 = $1)
	default_val=$1
	shift

	DEFSTR="Y/n"
	if [[ ${default_val} = false ]]; then
		DEFSTR="y/N"
	fi

	if [[ ${NOCONFIRM} != 0 ]]; then
		# If no confirm, then just fill empty reply.
		REPLY=""
	else
		# Prompt the user for next step
		read -p "Would you like to ${question} (${DEFSTR})? " -n 1 -r
		echo # New Line
	fi

	if [[ $REPLY =~ ^[Yy]$ ]] || [[ $REPLY = "" && ${default_val} = true ]]; then
		$@
	fi
}

function bail_error()
{
	exit 1
}

function install_missing_os_deps()
{
	NOPKGMANAGER=false
	PKGSTOINSTALL=$@
	# Debian, Ubuntu and derivatives (with apt-get)
	if which apt-get &> /dev/null; then
		sudo apt-get install -y $PKGSTOINSTALL
	# OpenSuse (with zypper)
	elif which zypper &> /dev/null; then
		sudo zypper in $PKGSTOINSTALL
	# Mandriva (with urpmi)
	elif which urpmi &> /dev/null; then
		sudo urpmi $PKGSTOINSTALL
	# Fedora and CentOS (with yum)
	elif which yum &> /dev/null; then
		sudo yum install $PKGSTOINSTALL
	# ArchLinux (with pacman)
	elif which pacman &> /dev/null; then
		sudo pacman --noconfirm -Sy $PKGSTOINSTALL
	elif which brew &> /dev/null; then
		brew tap homebrew/dupes	
		brew install $PKGSTOINSTALL
		brew link --force gettext
	# Else, if no package manager has been founded
	else
		NOPKGMANAGER=true
	fi

	# Check if installation is successful
	if [[ $? = 0 && false = $NOPKGMANAGER ]] ; then
		echo "All dependencies are satisfied."
	# Else, if installation isn't successful
	else
		echo "ERROR: impossible to found a package manager in your system. Please, install manually: ${PKGSTOINSTALL}."
		opt_oper "Exit" true bail_error
	fi
}

function check_n_install_os_deps()
{
	# What dependencies are missing?
	PKGSTOINSTALL=""

	# Debian, Ubuntu (with dpkg)
	if which dpkg &> /dev/null; then
		DEPENDENCIES=(${DEBIAN_DEPENDS[@]})
		QCMD="dpkg -l | grep -w \"ii\s\s\$i \""
	# OpenSuse, Mandriva, Fedora, CentOs, ecc. (with rpm)
	elif which rpm &> /dev/null; then
		DEPENDENCIES=(${RH_DEPENDS[@]})
		QCMD="rpm -q \$i"
	# ArchLinux (with pacman)
	elif which pacman &> /dev/null; then
		DEPENDENCIES=(${ARCH_DEPENDS[@]})
		QCMD="pacman -Qq | grep \"\$i\" || pacman -Qqg | grep \"\$i\""
	elif which brew &> /dev/null; then
		MAC_MODE=true
		DEPENDENCIES=(${BREW_DEPENDS[@]})
		QCMD="brew list --versions \$i | grep \$i"
	else
		echo "ERROR: Couldn't find package manager"
		opt_oper "Exit" true bail_error
		return
	fi

	for i in "${DEPENDENCIES[@]}"
	do
		if [[ ! `eval $QCMD` ]]; then
			PKGSTOINSTALL=$PKGSTOINSTALL" "$i
		fi
	done

	if [ "$PKGSTOINSTALL" != "" ]; then
		opt_oper "Install missing dependancies" true install_missing_os_deps $PKGSTOINSTALL
	fi
}

function install_plugins() {
	${ENV_DIR_PATH}/tmux/tpm/bin/install_plugins
	vim "+call dein#install()" +qall
}

function config_git() {
	git config --global core.editor "vim"
	git config --global merge.tool "vimdiff"
	git config --global color.ui auto
	git config --global branch.autosetuprebase always
	git config --global log.decorate true
	git config --global log.date relative
}

function set_default_zsh() {
	if [[ -x /bin/zsh ]]; then
		chsh -s /bin/zsh
	else
		echo "Zsh was not found on your system. (/bin/zsh)"
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

	# Download Dein for vim plugin managment
	git clone https://github.com/Shougo/dein.vim vim/dein/repos/github.com/Shougo/dein.vim
}

function install_xfce4_theme() {
	pushd ~
	git clone https://github.com/sgerrand/xfce4-terminal-colors-solarized.git
	pushd xfce4-terminal-colors-solarized
	cp dark/terminalrc ~/.config/xfce4/terminal/terminalrc
	popd
	rm -Rf xfce4-terminal-colors-solarized
	popd
}

if [[ ${MAC_MODE} = false ]]; then
	function install_powerline_fonts() {
		pushd ~
		wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
		wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
		wget https://raw.githubusercontent.com/powerline/fonts/master/Inconsolata/Inconsolata%20for%20Powerline.otf

		mkdir -p ~/.fonts/ && mv *.otf ~/.fonts/
		fc-cache -vf ~/.fonts
		mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
		popd
	}
else
	function install_powerline_fonts() {
		pushd ~
		pip install --user powerline-status
		popd
	}
fi

function install_xfce_shortcuts() {
	# TODO: backup instead of remove
	rm -f ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
	ln -s ${ENV_DIR_PATH}/xfce/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
}

function install_i3_config() {
	# TODO: backup instead of remove
	rm -Rf ~/.i3
	ln -s ${ENV_DIR_PATH}/i3/.i3 ~/.i3
	rm -f ~/.Xresources
	ln -s ${ENV_DIR_PATH}/i3/.Xresources ~/.Xresources

	# TODO: Make it proper, now it's arch only
	yaourt -S google-chrome telegram-desktop-bin nitrogen bmenu morc_menu xfce4-terminal i3-sensible-terminal lxappearance xfce4-clipman-plugin xfce4-power-manager --noconfirm
}

function install_dmenu_config() {
	# TODO: backup instead of remove
	rm -Rf ~/.dmenurc
	ln -s ${ENV_DIR_PATH}/dmenu/.dmenurc ~/.dmenurc

	rm -Rf ~/.config/dmenu-extended
	ln -s ${ENV_DIR_PATH}/dmenu-extended ~/.config/dmenu-extended

	yaourt -S dmenu-extended --noconfirm
}

# Install operation system dependancies
check_n_install_os_deps

# Loading initial enviorment
load_enviroment

# Install plugins
opt_oper "Download and install all plugins now" true install_plugins

# Config git
git config fetch.recurseSubmodules true
opt_oper "Configure git" true config_git

# Install powerline-fonts
opt_oper "Install powerline fonts for local user" false install_powerline_fonts

if [[ ${MAC_MODE} = false ]]; then
	# Install terminal theme
	opt_oper "Download and install XFCE4 terminal theme" false install_xfce4_theme

	# Update keyboard shortcuts
	opt_oper "Do you want to replace XFCE4 keyboard shortcuts" false install_xfce_shortcuts

	opt_oper "Do you want to install dmenu config" false install_dmenu_config

	opt_oper "Do you want to install I3 config" false install_i3_config
fi

# Change zsh to default shell (Keep last)
opt_oper "Use ZSH as default shell" true set_default_zsh
