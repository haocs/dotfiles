## My Linux configs
---

### Support Dist
* OpenSuse
* Debian/Ubuntu

### Included Configs
* Bash
* Neovim and vim
* Git
* Dev Languages and Tools: py, ruby, go, nodejs

### How to use
``` bash
# get git first
git clone https://github.com/haocs/dotfiles.git
cd dotfiles/scripts
# change git config
# ./config_git.sh
./config_nvim.sh
# For deb
./setup_deb.sh
# For suse
./setup_suse.sh
```

### Test?
I use docker to create a new system for testing.
Dockerfile is built for deb and it's easy to create one for openSUSE
``` bash
docker build -t 'dotfile' ./
docker run -it dotfile
# inside docker container
cd ./.dotfiles/scripts
./test_deb.sh
```
If everything goes well, you dotfile is ready :)
```

