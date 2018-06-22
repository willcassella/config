set color_border brgreen
set color_user brgreen
set color_host brgreen
set color_pwd brwhite
set color_error ff3f3f
 
function fish_prompt
    # Capture last status
    set last_status $status
 
    # Output a nice little box with username, host, and pwd
    set_color $color_border; echo -n '[ '
    set_color $color_user; echo -n (whoami)
    set_color $color_host; echo -n '@'(hostname)':'
    set_color $color_pwd; echo -n (prompt_pwd)
    set_color $color_border; echo -n ' ]'
 
    # Print last status if error
    if test $last_status -ne 0;
        set_color $color_error; echo -n '['$last_status']'
    end
 
    # Put command on a new line
    set_color $color_border; echo; echo -n '$ '
end
