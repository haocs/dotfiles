#!/bin/bash

is_exist() {
	type "$1" > /dev/null 2>&1;
}

install_go() {
	url = "https://storage.googleapis.com/golang/"
	pkgName = "go1.5.linux-amd64.tar.gz"
	wget "$url/$pkgName"
	sudo tart -C /usr/local -xzf "$pkgName"
	# Set Gopath
	if [ -f "~/.vimrc" ];
	then
		echo "set golng config"
		echo "export GOROOT=/usr/local/go" | tee ~/.vimrc
		echo "export PATH=$GOROOT/bin:$PATH" | tee ~/.vimcr
	else 
		echo ".vimrc is not found, you have to setup the config yourselft"
	fi
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
	echo "Install python3"
	sudo apt-get install python3
	sudo apt-get install python3-pip
else
	echo "python3 exists"
fi

if ! is_exist ruby ;
then
	echo "Install ruby"
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	\curl -sSL https://get.rvm.io | bash -s stable --ruby
else
	echo "ruby exists"
fi
