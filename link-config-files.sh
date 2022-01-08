#!/bin/bash
ln -s $(readlink -f bash/.bashrc) ~/.bashrc
ln -s $(readlink -f oh-my-zsh/oh-my-zsh.sh) ~/.oh-my-zsh/oh-my-zsh.sh
ln -s $(readlink -f oh-my-zsh/my-theme.zsh-theme) ~/.oh-my-zsh/themes/my-theme.zsh-theme
mkdir ~/bin 2> /dev/null
ln -s $(readlink -f i3/bin/monitor-switch.sh) ~/bin/monitor-switch.sh
ln -s $(readlink -f i3/config) ~/.config/i3/config
ln -s $(readlink -f nvim/init.vim) ~/.config/nvim/init.vim
ln -s $(readlink -f conky/conky.conf) ~/.config/conky/conky.conf
ln -s $(readlink -f alacritty/alacritty.yml) ~/.config/alacritty/alacritty.yml
ln -s $(readlink -f rofi/config) ~/.config/rofi/config
ln -s $(readlink -f gdb/.gdbinit) ~/.gdbinit
ln -s $(readlink -f emacs/.spacemacs) ~/.spacemacs
ln -s $(readlink -f i3/i3blocks/config) ~/.config/i3blocks/config

