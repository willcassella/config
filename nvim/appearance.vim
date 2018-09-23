" BASIC VISUAL SETTINGS

syntax on " Enable syntax highlighting

set number " Show line number on current line
"set relativenumber " Show other lines as relative to cursor (disabled due to lag)
"set cursorline " Highlight cursor line (disabled due to lag)
set nowrap " Wrapping is annoying

set showmatch " Show matching brackets
set matchtime=1 " Cursor restores after highlighting matching bracket in .1 seconds

if g:plugins_loaded && g:pretty
    " THEME CONFIGURATION
    if has('nvim')
        set termguicolors
    else
        let t_Co=256
    endif

    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'onedark'
    silent! colorscheme onedark

    " PLUGIN VISUAL SETTINGS
    let g:gitgutter_sign_added = '┃'
    let g:gitgutter_sign_modified = '╏'
    let g:gitgutter_sign_modified_removed = '╏'
    let g:gitgutter_sign_removed = '┇'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '┃'
    let g:airline#extensions#tabline#right_sep = ' '
    let g:airline#extensions#tabline#right_alt_sep = '┃'

    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
elseif g:plugins_loaded
    " THEME CONFIGURATION (plugins, not pretty)
    let g:airline_theme = 'minimalist'
    silent! colorscheme onedark

    " PLUGIN VISUAL SETTINGS (not pretty)
    let g:gitgutter_sign_added = '++'
    let g:gitgutter_sign_modified = '~~'
    let g:gitbutter_sign_modified_removed = '~~'
    let g:gitgutter_sign_removed = '--'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#right_sep = ' '
    let g:airline#extensions#tabline#right_alt_sep = '|'
elseif g:pretty
    " THEME CONFIGURATION (pretty, no plugins)
    if has('nvim')
        set termguicolors
    else
        let t_Co=256
    endif

    silent! colorscheme slate
else
    " THEME CONFIGURATION (not pretty, no plugins)
    silent! colorscheme desert
endif
