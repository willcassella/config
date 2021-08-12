#!/bin/sh
if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi
exec xclip -out -selection clipboard
