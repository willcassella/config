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
