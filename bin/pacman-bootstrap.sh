#!/usr/bin/env zsh

if [[ "$1" != "pacman" && "$1" != "aur" ]]; then
  echo "Usage: $0 <pacman|aur>"
  exit 1
fi

zmodload -ap zsh/mapfile mapfile
packages=( ${(f)mapfile[/home/maximbaz/.dotfiles/packages/pacman.$1.list]} )

if [[ "$1" == "pacman" ]]; then
  sudo pacman -Sy "$packages[@]"
else
  yay -S "$packages[@]"
fi
