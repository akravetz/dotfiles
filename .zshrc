export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

alias gcm='git checkout main'
alias gp='git pull'
alias gmm='git fetch origin main && git merge origin/main'
alias gcb='git checkout -b'
alias j='jobs'

eval "$(direnv hook zsh)"
