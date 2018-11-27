## My dotfiles 
---

### Support Dist
* openSUSE
* Debian/Ubuntu
* macOS

### Included Configs
* Bash
* Neovim
* Vim(may not working)
* Git
* Dev Languages installation: py, ruby, go, nodejs

### How to use
``` bash
# make sure git is installed
git clone https://github.com/haocs/dotfiles.git "$HOME/.dotfiles"
cd $HOME/.dotfiles/bin

# For deb
source ./setup_deb.sh
# For suse
source ./setup_suse.sh
# For macos
source ./setup_darwin.sh

# To only config git
./config_git.sh
# To only config bash
./config_bash.sh

```

### Note
* For openSUSE, Neovim is built from `git clone https://github.com/haocs/neovim.git` for consitent experience.
* For macOS, Neovim is installed from latest brew tap

