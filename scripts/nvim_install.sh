#!/bin/sh

install_vimrc () {

	NVIM_INSTALL_DIR="$HOME/.config/nvim"
	NVIM_S_DIR=$(readlink -f "$(pwd)/../nvim")

    if [ -e "$NVIM_INSTALL_DIR/init.vim" ];
    then
	    echo "init.vim exists will make it init.vim_bk"
	    mv "$NVIM_INSTALL_DIR/init.vim" "$NVIM_INSTALL_DIR/init.vim_vk"
    fi
    if [ ! -d "$NVIM_INSTALL_DIR" ];
    then
	    echo "create new folder"
	    mkdir -p "$NVIM_INSTALL_DIR"
    fi

    ln -s "$NVIM_S_DIR/init.vim" `readlink -f "$NVIM_INSTALL_DIR/init.vim"`

	echo "alias vim='nvim'" | tee -a "$HOME/.bashrc"
	. "$HOME/.bashrc"
    echo "Installed and configured nvim."
}

export -f install_vimrc
# install_vimrc
