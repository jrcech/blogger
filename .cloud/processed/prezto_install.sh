#!/usr/bin/env zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

git clone https://github.com/jrcech/vps_dotfiles ~/.dotfiles

~/.dotfiles/install.sh
