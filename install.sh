#!/usr/bin/env bash
sudo pacman -S curl yaourt fish
chsh -s `which fish`
yaourt -S pikaur
fish --command='alias pacman pikaur; and funcsave pacman'
pikaur -S neovim ctags python-neovim
fish --command='alias vim nvim; and funcsave vim'
mkdir -p ~/.config/nvim
ln -s '$PWD/.vimrc' ~/.vimrc
ln -s ~/.vimrc ~/.config/nvim/init.vim
ln -s '$PWD/.gitconfig' ~/.gitconfig
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py
rm get-pip.py
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish --command='fisher slavfox/foxfish'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
