#!/usr/bin/env bash

RED='\e[0;31m'
YELLOW='\e[1;33m'
BLUE='\e[0;34m'
NC='\e[0m' # No Color

exists() {
	type "$1" > /dev/null 2>&1;
}

init() {
	if [ ! -d "$HOME/.local/bin" ]; then mkdir -p "$HOME/.local/bin"; fi
	sudo apt-get install -y build-essential
}

install_go() {
	# Install to ~/.local/bin
	url="https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz"
	wget -qO- "$url" | tar -zxv -C "$HOME/.local/bin"
	# Set Gopath
	if [ -f "$HOME/.bashrc" ] ;
	then
		echo 'export GOROOT=$HOME/.local/bin/go' | tee -a "$HOME/.bashrc"
		echo 'export PATH=$GOROOT/bin:$PATH' | tee -a "$HOME/.bashrc"
	else
		echo "Set GOROOT manually!"
	fi
}

install_py3() {
	sudo apt-get install python3
	pip_url="https://bootstrap.pypa.io/get-pip.py"
	wget -qO- "$pip_url" | sudo python
	wget -qO- "$pip_url" | sudo python3

	sudo pip install pylint
	sudo pip install jedi
}

install_nodejs() {
	curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
	sudo apt-get install -y nodejs
}

install_ruby() {
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	\curl -sSL https://get.rvm.io | bash -s stable --ruby
}

install_neovim() {
	CUR=`pwd`
	sudo apt-get install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
	# build from source
	git clone https://github.com/neovim/neovim.git
	cd neovim
	rm -r build
	make clean
	sudo make CMAKE_BUILD_TYPE=Release
	sudo make install
	cd "$CUR"
	# Install py client for neovim
	sudo pip install neovim
}

echo "Install dependency..."
init
if ! exists wget ; then sudo apt-get -y install wget curl; fi
if ! exists go ; then install_go; fi
if ! exists python ; then sudo apt-get install python; fi
if ! exists pip; then install_py3; fi
if ! exists node; then install_nodejs; fi
if ! exists ruby ; then install_ruby; fi
if ! exists nvim ; then install_neovim; fi

load_configs() {
	# load git, nvim and bash configs
	source ./config_git.sh
	source ./config_nvim.sh
	source ./config_bash.sh
}

echo "Install dependency..."
init
if ! exists wget ; then sudo zypper install git wget curl; fi
if ! exists go ; then install_go; fi
if ! exists pip; then install_py3; fi
if ! exists node; then install_nodejs; fi
if ! exists ruby ; then install_ruby; fi
if ! exists nvim ; then install_neovim; fi

export -f load_configs

echo -e "${BLUE}Optional Commands:"
echo -e "${BLUE}setup: ${YELLOW}load_configs"
