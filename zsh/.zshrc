HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
export PROMPT='%F{green}%n@%m%F{white}:%F{blue}%~%F{white}$ '
