#!/usr/bin/env sh -x
if [ $(whoami) != "fox" ]; then
    echo "Log in as fox before running this!"
    exit 1
fi
set -e
PS4="\n\033[1;33m::\033[0m "; set -x

git clone https://github.com/slavfox/dots.git ~/dots
# delete if exists
sudo rm -rf /etc/nixos/cfg/
sudo ln -s ~/dots/dotfiles/nixos /etc/nixos/cfg/

sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

sudo nixos-rebuild switch --upgrade

nix-channel -iA nixos-ansible

~/dots/bin/sync-dots
