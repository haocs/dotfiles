#!/usr/bin/bash

if [ -f ~/.gitconfig ]; then
	echo "Found old .gitconfig, will archive ~> .gitconfig_bk"
	mv ~/.gitconfig ~/.gitconfig_bk
fi

mv .gitconfig ~/ 
