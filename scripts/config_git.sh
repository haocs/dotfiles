#!/usr/bin/env bash

INSTALL_TO="$HOME"
S_DIR=$(readlink -f "$(pwd)/../git")

if [ -f "$INSTALL_TO/.gitconfig" ]; then
	echo "Found old .gitconfig, will archive ~> .gitconfig_bk"
	mv "$INSTALL_TO/.gitconfig" "$INSTALL_TO/.gitconfig_bk"
elif [ -L "$INSTALL_TO/.gitconfig" ]; then
	echo "Found old .gitconfig ln, will remove"
	rm "$INSTALL_TO/.gitconfig"
fi

# create a soft link
echo "Creating soft link for config file"
ln -s "$S_DIR/gitconfig" "$INSTALL_TO/.gitconfig"
echo "Done"
