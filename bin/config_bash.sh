#!/usr/bin/env bash

INSTALL_TO="$HOME"
S_DIR=$(readlink -f "$(pwd)/../bash")

if [ ! -f "$INSTALL_TO/.bash_profile" ]; then
	echo "Create .bash_profile"
	ln -s "$S_DIR/bash_profile" "$INSTALL_TO/.bash_profile"
fi

if [ -f "$INSTALL_TO/.bashrc" ]; then
	echo "Config .bashrc"
	# copy alias files
	echo 'test -s ~/.bash_alias && . ~/.bash_alias || true' >> "$INSTALL_TO/.bashrc"
	ln -nfs "$(readlink -f "$(pwd)/../bash")/bash_alias" "$INSTALL_TO/.bash_alias"
	# copy commands files
	echo 'test -s ~/.bash_commands && . ~/.bash_commands || true' >> "$INSTALL_TO/.bashrc"
	ln -nfs "$(readlink -f "$(pwd)/../bash")/bash_commands" "$INSTALL_TO/.bash_commands"

	# Update .config
	source "$INSTALL_TO/.bashrc"
fi
