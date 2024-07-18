" Statusline
func! TerminalBufferName()
    " We want terminal filenames have the form: term://PWD//PID:CMD
    return '!' . join(split(bufname(), ':')[2:], ':')
endfunc

func! StatuslineParts(parts)
    " Eval each expression in g:statusline_extra and remove empty results
    let l:results = map(copy(a:parts), 'eval(v:val)')
    call filter(l:results, 'len(v:val)')
    return trim(join([''] + l:results, ' | '))
endfunc
let g:statusline_left_parts = []
let g:statusline_right_parts = ['&fenc', '&ff', '&ft']

func! Statusline()
    let l:buf = winbufnr(g:statusline_winid)

    " Style terminal buffers differently
    if getbufvar(l:buf, '&buftype') == 'terminal'
        return ' %{TerminalBufferName()}%<%=[term] '
    endif

    let l:left_part = '%t%( %m%r%)%<'
    let l:right_part = '%l/%L:%c #%{winnr()}'

    " Style non-current buffers differently
    if win_getid() != g:statusline_winid
        return ' ' . l:left_part . '%=' . l:right_part . ' '
    endif

    " Current, non-terminal buffers include extra parts
    let l:left_part .= '%( %{StatuslineParts(g:statusline_left_parts)}%)'
    let l:right_part .= '%( %{StatuslineParts(g:statusline_right_parts)}%)'
    return ' ' . l:left_part . '%=' . l:right_part . ' '
endfunc
set statusline=%!Statusline()

" PLUGINS
if exists('g:load_plugins') && g:load_plugins
    call plug#begin()
    Plug 'airblade/vim-gitgutter'
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-plug'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/playground'
    Plug 'willcassella/nvim-gn'
    Plug 'Mofiqul/vscode.nvim'
    call plug#end()

    luafile $HOME/config/neovim/treesitter.lua

    " Fugitive
    let g:statusline_left_parts += ['FugitiveHead()']

    " FZF.Vim
    nnoremap <silent> <leader>f <Cmd>Files<CR>
    nnoremap <silent> <leader>d <Cmd>Buffers<CR>
    nnoremap <silent> <leader>g <Cmd>History<CR>

    " ARGWRAP
    nnoremap <silent> <leader>* <Cmd>ArgWrap<CR>

    " CoC
    let g:statusline_left_parts += ['coc#status()']
    au User CocStatusChange,CocDiagnosticChange ++nested let &ro = &ro

    " Make it so that [e and ]e can navigate between CoC errors
    nmap <silent> [e <Plug>(coc-diagnostic-prev)
    nmap <silent> ]e <Plug>(coc-diagnostic-next)

    " Remap go to definition
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> gh <Cmd>call CocAction('doHover')<CR>

    " User <leader>cf for Coc fix
    nnoremap <silent> <leader>cf <Cmd>call CocAction('doQuickfix')<CR>

    " Use <C-S> and <C-Space> to search for symbols
    nnoremap <C-S> <Cmd>CocList symbols<CR>
    nnoremap <C-Space> <Cmd>CocList outline<CR>

    " Git gutter
    let g:gitgutter_sign_priority = 5
    let g:gitgutter_sign_added = '┃'
    let g:gitgutter_sign_modified = '╏'
    let g:gitgutter_sign_modified_removed = '╏'
    let g:gitgutter_sign_removed = '┇'
endif

" Load project vimrc files (no-op if not defined)
" I prefer this over 'use vim' in .envrc since it's more predictable
" (run once, unconditionally).
for file in split($PROJECT_VIMRC, ':')
    if len(file)
        exe 'source' file
    endif
endfor
