#!/bin/sh
INSTALL_TO="$HOME/.config/nvim"
CUR_DIR=`pwd`

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

install_vimrc () {
    if [ -e "$INSTALL_TO/init.vim" ];
    then
	    echo "init.vim exists will make it init.vim_bk"
	    mv "$INSTALL_TO/init.vim" "$INSTALL_TO/init.vim_vk"
    fi
    if [ ! -d "$INSTALL_TO" ];
    then
	    echo "create new folder"
	    mkdir -p "$INSTALL_TO"
    fi

    ln -s "$CUR_DIR/init.vim" `readlink -f "$INSTALL_TO/init.vim"`


	#echo "cp init.vim file to ~/.config/nvim/ MANUALLY"
    echo "Installed and configured nvim."
}

install_vimrc
