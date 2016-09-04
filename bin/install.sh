#!/bin/bash

NOCONFIRM=${NOCONFIRM:-0}
DEBIAN_DEPENDS=(git-core python-pip python-setuptools)
RH_DEPENDS=(git-all python-pip python-setuptools)
ARCH_DEPENDS=(yaourt git python2-pip python2-setuptools)

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

function load_enviroment() {
	# TODO: Return CD, remove -b ansible
	# cd ~

	# Clone the repository
	git clone --recursive https://github.com/DxCx/WorkEnv -b ansible .workenv_installer

	# Install Ansible
	cd .workenv_installer/ansible
	chmod +x ./setup.py
	sudo ./setup.py install

	cd ../..
}

function ansible_kickstart() {
	git clone --recursive https://github.com/DxCx/dotfiles-playbook .dotfiles
	cd .dotfiles
	./install.sh
	cd ..
}

function cleanup() {
	sudo rm -Rf .workenv_installer/
}

# Install operation system dependancies
check_n_install_os_deps

# Loading initial enviorment
load_enviroment

# cleanup installer
cleanup

# Ansible will take us from here... :)
ansible_kickstart
