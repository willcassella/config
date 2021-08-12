set fish_greeting ''
set fish_prompt_pwd_dir_length 0

# Hook direnv if it's installed
if type -q direnv
    direnv hook fish | source
end
