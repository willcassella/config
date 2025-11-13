set fish_greeting ''
set fish_prompt_pwd_dir_length 0

bind alt-h backward-word
bind alt-l forward-word

# Hook direnv if it's installed
if type -q direnv
    direnv hook fish | source
end

set COLOR_BORDER brgreen
set COLOR_USER brgreen
set COLOR_HOST brgreen
set COLOR_PWD brwhite
set COLOR_ERROR ff3f3f
set COLOR_GIT_BRANCH brwhite
set COLOR_GIT_NOBRANCH $color_error
set COLOR_GIT_UNSTAGED bryellow
set COLOR_GIT_STAGED brgreen

function fish_prompt
    # Capture last status
    set last_status $status

    # Set host name/box name
    set box_name (hostname)
    if set -q CONTAINER_ID
        set box_name "$box_name($CONTAINER_ID)"
    end

    # Output a nice little box with username, host, and pwd
    set_color $COLOR_BORDER; echo -n '[ '
    set_color $COLOR_USER; echo -n (whoami)
    set_color $COLOR_HOST; echo -n "@$box_name:"
    set_color $COLOR_PWD; echo -n (prompt_pwd)
    set_color $COLOR_BORDER; echo -n ' ]'

    # Get the current branch we're on, if we're in a git repo
    if type -q git
        and set -l git_branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        # Output git branch, or HEAD if detached
        set_color $COLOR_BORDER; echo -n '['
        if [ "$git_branch" = HEAD ]
            set_color $COLOR_GIT_NOBRANCH; echo -n HEAD
        else
            set_color $COLOR_GIT_BRANCH; echo -n $git_branch
        end

        # Output number unstaged and staged changes
        set -l unstaged_changes (git diff --name-only | uniq | wc -l | tr -d ' ')
        set -l staged_changes (git diff --name-only --staged | wc -l | tr -d ' ')
        if [ "$unstaged_changes" -ne 0 ]
            set_color $COLOR_GIT_UNSTAGED; echo -n " ~$unstaged_changes"
        end
        if [ "$staged_changes" -ne 0 ]
            set_color $COLOR_GIT_STAGED; echo -n " ✔$staged_changes"
        end

        set_color $COLOR_BORDER; echo -n ']'
    end

    # Print last status if error
    if test $last_status -ne 0
        set_color $COLOR_ERROR; printf '[%d]' $last_status
    end

    # Put command on a new line
    set_color $COLOR_BORDER; printf '\n$ '
    set_color normal
end
