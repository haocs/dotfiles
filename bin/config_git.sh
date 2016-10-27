#!/usr/bin/env bash

INSTALL_TO="$HOME"
S_DIR="$HOME/.dotfiles/git"

if [ -f "$INSTALL_TO/.gitconfig" ]; then
	echo "found old .gitconfig, will archive ~> .gitconfig_bk"
	mv "$INSTALL_TO/.gitconfig" "$INSTALL_TO/.gitconfig_bk"
elif [ -L "$INSTALL_TO/.gitconfig" ]; then
	echo "rm old ln: `ls $INSTALL_TO/.gitconfig`"
	rm "$INSTALL_TO/.gitconfig"
fi

# create a soft link
echo "creating soft link for config file"
ln -s "$S_DIR/gitconfig" "$INSTALL_TO/.gitconfig"
echo "Done"
