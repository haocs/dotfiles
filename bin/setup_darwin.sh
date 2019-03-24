#!/usr/bin/env bash

exists() {
  type "$1" > /dev/null 2>&1;
}

init() {
  if [ ! -d "$HOME/.local/bin" ]; then mkdir -p "$HOME/.local/bin"; fi
  # Make sure homebrew is installed and updated
  if ! exists brew; then install_homebrew; fi
  brew update
}

install_homebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_pip() {
  brew install python3
  pip_url="https://bootstrap.pypa.io/get-pip.py"
  wget -qO- "$pip_url" | python3

  sudo pip install jedi
  sudo pip install python3-pylint
}

install_neovim() {
  brew install neovim/neovim/neovim
  pip install neovim
}

load_configs() {
  # load git, nvim and bash configs
  source ./config_git.sh
  source ./config_nvim.sh
  source ./config_bash.sh
}

echo "Install dependency..."
init
if ! exists wget ; then brew install wget --with-libressl; fi
if ! exists pip; then install_pip; fi
if ! exists nvim ; then install_neovim; fi

