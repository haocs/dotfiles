#!/bin/bash

is_exist() {
	type "$1" > /dev/null 2>&1;
}

install_go() {
	url="https://storage.googleapis.com/golang/"
	pkgName="go1.5.linux-amd64.tar.gz"
	wget "$url/$pkgName"
	sudo tar -C /usr/local -xzf "$pkgName"
	# Set Gopath
		echo "Manually set golng config"
		echo "export GOROOT=/usr/local/go"
		echo "export PATH=$GOROOT/bin:$PATH"
}

echo "Install dependency..."

if ! is_exist go ;
then
	echo "Install golang";
	install_go;
else
	echo "go exists"
fi

if ! is_exist python3 ;
then
	echo "Install python3 and pip"
	sudo apt-get install software-properties-common
	sudo apt-get install python-software-properties

	# Install Pip for python and python3
	sudo apt-get install python-dev python-pip python3-dev python3-pip
	""" If error on older versions, uncomment following lines """
	# sudo apt-get install python-dev python-pip python3-dev
	# sudo apt-get install python3-setuptools
	# sudo easy_install3 pip

else
	echo "python3 exists"
fi

if ! is_exist nvim ;
then
	echo "Install NeoVim"
    sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install neovim
else 
	echo "NeoVim exists"
fi

if ! is_exist ruby ;
then
	echo "Install ruby"
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	\curl -sSL https://get.rvm.io | bash -s stable --ruby
else
	echo "ruby exists"
fi
