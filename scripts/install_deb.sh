#!/bin/bash

install_neovim() {
	echo "Installing NeoVim"
    sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install neovim
	# To use system clipboard in neovim
	sudo apt-get install xclip
}


export -f install_neovim
export -f install_go
export -f install_py3
