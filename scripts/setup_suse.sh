#!/bin/bash

exists() {
	type "$1" > /dev/null 2>&1;
}

init() {
	if [ ! -d "$HOME/.local/bin" ]; then mkdir -p "$HOME/.local/bin"; fi
}

install_go() {
	# Install to ~/.local/bin
	url="https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz"
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

install_ruby() {
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	\curl -sSL https://get.rvm.io | bash -s stable --ruby
}

install_neovim() {
	sudo zypper install libtool autoconf automake cmake gcc-c++
	# build from source
	git clone git@github.com:neovim/neovim.git
	cd neovim
	rm -r build
	make clean
	sudo make CMAKE_BUILD_TYPE=Release
	sudo make install
	# ln syntax.vim for neovim
	sudo ln -s /usr/share/vim/current /usr/local/share/nvim
	# for YCM
	sudo pip install neovim
	echo "To use YCM, go to .config/nvim/ and compile source files"
	cd ..
}


echo "Install dependency..."
init
if ! exists wget ; then sudo zypper install git wget curl; fi
if ! exists go ; then install_go; fi
if ! exists python3 ; then install_py3; fi
if ! exists ruby ; then install_ruby; fi
if ! exists nvim ; then install_neovim; fi

# Update Configs
if [ -f "$HOME/.bashrc" ] ;
then
	# copy alias files
	echo 'test -s ~/.bash_alias && . ~/.bash_alias || true' >> "$HOME/.bashrc"
	ln -s "$(readlink -f "$(pwd)/../bash")/bash_alias" "$HOME/.bash_alias"
	source "$HOME/.bashrc"
fi