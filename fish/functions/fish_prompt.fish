set color_border brgreen
set color_user brgreen
set color_host brgreen
set color_pwd brwhite
set color_error ff3f3f
set color_git_branch brwhite
set color_git_nobranch $color_error
set color_git_unstaged bryellow
set color_git_staged brgreen
 
function fish_prompt
    # Capture last status
    set last_status $status
 
    # Output a nice little box with username, host, and pwd
    set_color $color_border; echo -n '[ '
    set_color $color_user; echo -n (whoami)
    set_color $color_host; echo -n '@'(hostname)':'
    set_color $color_pwd; echo -n (prompt_pwd)
    set_color $color_border; echo -n ' ]'

    # Get the current branch we're on, if we're in a git repo
    if set -l git_branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        # Output git branch, or HEAD if detached
        set_color $color_border; echo -n '['
        if [ "$git_branch" = HEAD ]
            set_color $color_git_nobranch; echo -n HEAD
        else
            set_color $color_git_branch; echo -n $git_branch
        end

        # Output number unstaged and staged changes
        set -l unstaged_changes (git diff --name-only | uniq | wc -l)
        set -l staged_changes (git diff --name-only --staged | wc -l)
        if [ "$unstaged_changes" -ne 0 ]
            set_color $color_git_unstaged; echo -n " ~$unstaged_changes"
        end
        if [ "$staged_changes" -ne 0 ]
            set_color $color_git_staged; echo -n " ✔$staged_changes"
        end

        set_color $color_border; echo -n ']'
    end
 
    # Print last status if error
    if test $last_status -ne 0
        set_color $color_error; printf '[%d]' $last_status
    end
 
    # Put command on a new line
    set_color $color_border; printf '\n$ '
    set_color normal
end
