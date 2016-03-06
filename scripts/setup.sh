#!/bin/bash

exists() {
	type "$1" > /dev/null 2>&1;
}

install_go() {
	# Install to local
	if [ ! -d "$HOME/.local/bin" ]; then mkdir -p "$HOME/.local/bin"; fi
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
	sudo apt-get install python3
	pip_url="https://bootstrap.pypa.io/get-pip.py"
	sudo wget -qO- "$pip_url" | python
	sudo wget -qO- "$pip_url" | python3
	sduo pip install pylint
}

echo "Install dependency..."
if ! exists wget ; then sudo apt-get -y install wget curl; fi

if ! exists go ; then install_go; fi
if ! exists python ; then sudo apt-get install python; fi
if ! exists python3 ; then install_py3; fi
if ! exists ruby ;
then
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	\curl -sSL https://get.rvm.io | bash -s stable --ruby
fi

if ! exists nvim ;
then
    sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install neovim
	# To use system clipboard in neovim
	sudo apt-get install xclip
fi

# Update Configs
if [ -f "$HOME/.bashrc" ] ;
then
	# copy aliases files
	ln -s "$(readlink -f "$(pwd)/../bash")/bash_aliases" "$HOME/.bash_aliases"
	source "$HOME/.bashrc"
fi
