set fish_greeting ''
set fish_prompt_pwd_dir_length 0

bind alt-h backward-word
bind alt-l forward-word

# Hook direnv if it's installed
if type -q direnv
    direnv hook fish | source
end
