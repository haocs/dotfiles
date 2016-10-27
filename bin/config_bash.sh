#!/usr/bin/env bash

INSTALL_TO="$HOME"
S_DIR="$HOME/.dotfiles/bash"

clean() {
  FILE="$1"
  if [ -L "$FILE" ]; then
    echo "rm old symlink: `ls "$FILE"`"
    rm "$FILE"
  fi
  if [ ! -f "$FILE" ]; then
    echo "create file: $FILE"
    touch "$FILE"
  fi
}

clean "$INSTALL_TO/.bash_profile"
clean "$INSTALL_TO/.bashrc"

# reference bashrc in bash_profile
echo 'test -s ~/.bashrc && . ~/.bashrc || true' >> "$INSTALL_TO/.bash_profile"
# copy alias files
echo 'test -s ~/.bash_alias && . ~/.bash_alias || true' >> "$INSTALL_TO/.bashrc"
ln -nfs "$S_DIR/bash_alias" "$INSTALL_TO/.bash_alias"
# copy commands files
echo 'test -s ~/.bash_commands && . ~/.bash_commands || true' >> "$INSTALL_TO/.bashrc"
ln -nfs "$S_DIR/bash_commands" "$INSTALL_TO/.bash_commands"

echo "update .bashrc config"
source "$INSTALL_TO/.bashrc"

