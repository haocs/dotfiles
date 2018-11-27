#!/usr/bin/env bash

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

DES_DIR="$HOME"
SOURCE_DIR="$HOME/.dotfiles/bash"

clean "$DES_DIR/.bash_profile"
clean "$DES_DIR/.bashrc"

# link bash_alias and bash_commands
ln -nfs "$SOURCE_DIR/bash_alias" "$DES_DIR/.bash_alias"
ln -nfs "$SOURCE_DIR/bash_commands" "$DES_DIR/.bash_commands"

# reference bashrc in bash_profile
echo 'test -s ~/.bashrc && . ~/.bashrc || true' >> "$DES_DIR/.bash_profile"

# Append bash config
cat "$SOURCE_DIR/bash_config.txt" >> "$DES_DIR/.bashrc"

# Update .config
source "$DES_DIR/.bashrc"

