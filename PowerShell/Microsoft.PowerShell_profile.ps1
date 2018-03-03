function prompt {
    Write-Host ("" + $Env:username + "@" + $Env:computername) -nonewline -foregroundcolor DarkGray
    Write-Host (":") -nonewline -foregroundcolor Gray
    Write-Host ("" + $PWD) -nonewline -foregroundcolor DarkCyan
    Write-Host ("$") -nonewline -foregroundcolor Gray
    return " "
}
