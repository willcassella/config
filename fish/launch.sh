#!/bin/bash

# Script for launching fish instead of bash/zsh as the interactive shell.
# Still want to use bash for scripts and explicit invocations.
# Figuring that out is unfortunately kind of complicated, hence all these checks.

# Early exit if the shell is not interactive or attached to a TTY
if test ! -t 0 || [[ $- != *i* ]]; then
    return
fi

# Early exit if running in a "dumb" terminal (Emacs, some JetBrains internals)
if [[ "$TERM" == "dumb" ]]; then
    return
fi

WHICH_FISH=$(which fish)

# If we're currently running (or already ran) fish
if [[ $SHELL == $WHICH_FISH ]] || [[ -n $LAUNCHED_FISH ]]; then
    return
fi

export SHELL=$WHICH_FISH
export LAUNCHED_FISH=1
exec fish
