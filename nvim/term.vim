" Function for opening fish terminal in horizontal split
function OpenFish()
    new term://fish
    setlocal nonumber
    setlocal norelativenumber
endfunction

" Function for opening fish terminal in vertical split
function VOpenFish()
    vnew term://fish
    setlocal nonumber
    setlocal norelativenumber
endfunction

" Function for opening fish terminal in a tab
function TOpenFish()
    tabnew term://fish
    setlocal nonumber
    setlocal norelativenumber
endfunction

" Function for opening fish terminal in the current buffer
function EOpenFish()
    edit term://fish
    setlocal nonumber
    setlocal norelativenumber
endfunction

command Fish call OpenFish()
command VFish call VOpenFish()
command TFish call TOpenFish()
command EFish call EOpenFish()
