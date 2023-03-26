#!/usr/bin/env zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

git clone https://github.com/${DOTFILES_REPO_USER}/${DOTFILES_REPO} ~/.dotfiles

~/.dotfiles/install.sh
