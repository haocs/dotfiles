#!/usr/bin/env bash

INSTALL_TO="$HOME/.config/nvim"
S_DIR="$HOME/.dotfiles/nvim"

config_nvim() {
  if [ -e "$INSTALL_TO/init.vim" ]; then
    echo "init.vim exists will make it init.vim_bk"
    mv "$INSTALL_TO/init.vim" "$INSTALL_TO/init.vim_vk"
  fi

  if [ ! -d "$INSTALL_TO" ]; then
    echo "create new folder"
    mkdir -p "$INSTALL_TO"
  fi

  ln -s "$S_DIR/init.vim" "$INSTALL_TO/init.vim"

  echo "Installed and configured nvim."
}

config_nvim
