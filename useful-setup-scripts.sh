#!/bin/bash

# alias fdfind to fd for consistency outside Ubuntu 
mkdir ~/.local/bin 2> /dev/null
ln -s $(which fdfind) ~/.local/bin/fd
