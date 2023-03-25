# Bash
alias c='clear'
alias ls='ls -la'
alias s='sudo'
alias rld='source ~/.zshrc'

# Docker
alias dcb='docker compose build'
alias dcbnc='docker compose build --no-cache'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcw='docker compose exec web'
alias dcwb='docker compose exec web exec bundle'
alias dcd='docker compose down'
alias drst='docker compose kill && docker rmi -f $(docker images -q) && docker rm -f $(docker ps -a -q) && docker volume rm $(docker volume ls -q) && docker builder prune -a'
