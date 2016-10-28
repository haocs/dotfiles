#!/usr/bin/env bash

exists() {
  type "$1" > /dev/null 2>&1;
}

init() {
  if [ ! -d "$HOME/.local/bin" ]; then mkdir -p "$HOME/.local/bin"; fi
}

install_homebrew() {
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_py3() {
	sudo zypper install python3
	sudo zypper install python3-devel
	pip_url="https://bootstrap.pypa.io/get-pip.py"
	wget -qO- "$pip_url" | python3

	sudo pip install jedi
	sudo pip install python3-pylint
}


install_neovim() {
	brew install neovim/neovim/neovim
}


load_configs() {
	# load git, nvim and bash configs
	source ./config_git.sh
	source ./config_nvim.sh
	source ./config_bash.sh
}

echo "Install dependency..."
init
if ! exists wget ; then sudo zypper in wget; fi
if ! exists curl ; then sudo zypper in curl; fi
if ! exists go ; then install_go; fi
if ! exists pip; then install_py3; fi
if ! exists node; then install_nodejs; fi
if ! exists ruby ; then install_ruby; fi
if ! exists pip3; then install_py3; fi
if ! exists nvim ; then install_neovim; fi

