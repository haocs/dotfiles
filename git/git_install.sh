#!/bin/bash

if [ -f ~/.gitconfig ]; then
	echo "Found old .gitconfig, will archive ~> .gitconfig_bk"
	mv ~/.gitconfig ~/.gitconfig_bk
elif [ -L ~/.gitconfig ]; then
	echo "Found old .gitconfig ln, will remove"
	rm ~/.gitconfig
fi

# create a soft link
ln -s "$(pwd)/gitconfig" ~/.gitconfig
