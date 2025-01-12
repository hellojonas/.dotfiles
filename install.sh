#!/usr/bin/env bash

if [ ! -d "$HOME/.config" ]; then
	echo "creating .config directory"
	mkdir -p "$HOME/.config"
fi

echo "installing apps & dependencies"
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel ripgrep fzf go neovim tmux alacritty firefox

echo "creating symlink for configs"
ln -s $HOME/.dotfiles/bin/ $HOME/.local/bin
ln -s $HOME/.dotfiles/tmux/ $HOME/.config/tmux
ln -s $HOME/.dotfiles/nvim/ $HOME/.config/nvim
ln -s $HOME/.dotfiles/alacritty/ $HOME/.config/alacritty

echo "updating env"
echo 'export PATH=$HOME/.local/bin/:$PATH' >> $HOME/.bashrc
