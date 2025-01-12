#!/usr/bin/env bash

# update system, install apps and dependencies
echo "updating system"
sudo pacman -Syu --noconfirm
echo "installing apps & dependencies"
sudo pacman -S --noconfirm base-devel ripgrep fzf go neovim tmux alacritty firefox

# check if config floder exists
if [ ! -d "$HOME/.config" ]; then
	echo "creating .config directory"
	mkdir -p "$HOME/.config"
fi

# create symlink fo configs
echo "creating symlink for configs"
ln -s $HOME/.dotfiles/bin/ $HOME/.local/bin
ln -s $HOME/.dotfiles/tmux/ $HOME/.config/tmux
ln -s $HOME/.dotfiles/nvim/ $HOME/.config/nvim
ln -s $HOME/.dotfiles/alacritty/ $HOME/.config/alacritty

# install fonts
echo "installing fonts"
tar xzf $HOME/.dotfiles/fonts/SourceCodePro.tar.gz -C $HOME/.local/share/fonts
chmod 555 $HOME/.local/share/fonts/*
fc-cache

# update env
echo "updating env"
echo 'export PATH=$HOME/.local/bin/:$PATH' >> $HOME/.bashrc
