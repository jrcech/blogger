#!/usr/bin/env zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

sed -i "s/theme 'sorin'/theme 'powerlevel10k'/g" ~/.zpreztorc

sed -i "s/'completion'/'completion' \\\\\n  'syntax-highlighting'/g" ~/.zpreztorc
sed -i "s/'history-substring-search'/'history-substring-search' \\\\\n  'autosuggestions'/g" ~/.zpreztorc
sed -i '/^# zstyle.*:prezto:module:syntax-highlighting.*highlighters/,/^#.*root/s/^# //' ~/.zpreztorc

sed -i "s/# Customize to your needs.../# Customize to your needs...\\nsource .aliases.sh\\nZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'/g" ~/.zshrc
