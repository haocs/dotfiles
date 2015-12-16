#!/bin/sh
INSTALL_TO=~
CUR_DIR=`pwd`

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

install_vimrc () {
    [ -e "$INSTALL_TO/vimrc" ] && die "$INSTALL_TO/vimrc already exists."
    [ -e "~/.vim" ] && die "~/.vim already exists."
    [ -f "~/.vimrc" ] && die "~/.vimrc already exists."

    # Symlink .vimrc and .vimrc.local
    ln -s "$CUR_DIR/vimrc" "$INSTALL_TO/.vimrc" 
    ln -s "$CUR_DIR/vimrc.local" "$INSTALL_TO/.vimrc.local" 

    echo "Installed and configured vim."
}

install_vimrc
