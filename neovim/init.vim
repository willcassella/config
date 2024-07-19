func! StatuslineParts(parts)
    " Eval each expression in g:statusline_extra and remove empty results
    let l:results = map(copy(a:parts), 'eval(v:val)')
    call filter(l:results, 'len(v:val)')
    return trim(join([''] + l:results, ' | '))
endfunc
let g:statusline_left_parts = []
let g:statusline_right_parts = ['&fenc', '&ff', '&ft']

" PLUGINS
if exists('g:load_plugins') && g:load_plugins
    " Fugitive
    let g:statusline_left_parts += ['FugitiveHead()']

    " CoC
    let g:statusline_left_parts += ['coc#status()']
endif

" Load project vimrc files (no-op if not defined)
" I prefer this over 'use vim' in .envrc since it's more predictable
" (run once, unconditionally).
for file in split($PROJECT_VIMRC, ':')
    if len(file)
        exe 'source' file
    endif
endfor
