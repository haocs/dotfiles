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
	sudo zypper install python3
	pip_url="https://bootstrap.pypa.io/get-pip.py"
	wget -qO- "$pip_url" | sudo python3

	sudo pip install jedi
	sudo pip install python3-devel
}

install_nodejs() {
	NODEJS_VERSION="-6.3.0-113.1.x86_64"
	sudo zypper install nodejs
}

install_ruby() {
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	\curl -sSL https://get.rvm.io | bash -s stable --ruby
}

install_neovim() {
	CUR=`pwd`
	sudo zypper install libtool autoconf automake cmake gcc-c++
	sudo zypper install python3-devel python-devel
	# build from source
	git clone https://github.com/neovim/neovim.git
	cd neovim
	rm -r build
	make clean
	sudo make CMAKE_BUILD_TYPE=Release
	sudo make install
	# ln syntax.vim for neovim. ONLY for SUSE
	sudo ln -nfs /usr/share/vim/current /usr/local/share/nvim
	# for YCM
	sudo pip install neovim
	echo "To use YCM, go to .config/nvim/ and compile source files"
	cd "$CUR"
}

install_chrome() {
	sudo zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
	sudo zypper ref
	sudo zypper in google-chrome-stable
}

install_devtools() {
	sudo zypper in docker
	sudo usermod -aG docker $USER
}

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

export -f install_chrome
export -f install_devtools
export -f load_configs

echo -e "${BLUE}Optional Commands:"
echo -e "${BLUE}setup: ${YELLOW}load_configs"
echo -e "${BLUE}chrome: ${YELLOW}install_chrome"
echo -e "${BLUE}dev tools: ${YELLOW}sudo install_devtools"

