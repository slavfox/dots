#!/usr/bin/env sh
sudo pacman -S git python ansible
git clone --recursive https://github.com/slavfox/dots.git
cd dots
./sync.sh
