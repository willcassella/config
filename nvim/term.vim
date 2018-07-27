" Function for opening fish terminal in the current window
function OpenFish()
    edit term://fish
    setlocal nonumber
    setlocal norelativenumber
endfunction

" Function for opening fish terminal in new horizontal split
function HOpenFish()
    new term://fish
    setlocal nonumber
    setlocal norelativenumber
endfunction

" Function for opening fish terminal in a new vertical split
function VOpenFish()
    vnew term://fish
    setlocal nonumber
    setlocal norelativenumber
endfunction

command Fish call OpenFish()
command HFish call HOpenFish()
command VFish call VOpenFish()
