#!/bin/sh

install_neovim() {
	# build use make
	# for OSS need ln syntax.vim for neovim
	sudo ln -s /usr/share/vim/current /usr/local/share/nvim
}

export -f install_neovim

