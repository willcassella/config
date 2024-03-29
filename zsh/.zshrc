HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify inc_append_history
unsetopt beep
bindkey -e
export PROMPT='%F{green}%n@%m%F{white}:%F{blue}%~%F{white}$ '

autoload -Uz compinit && compinit
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
