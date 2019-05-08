function brg
    # Enumerate files where matches are found
    for f in (rg -l $argv)
        # Colorize those files with bat, and then re-search them
        echo
        echo $f':'
        bat --plain --color always $f | rg --line-number --context 3 $argv
    end
end
