" GENERAL OPTIONS
set nomodeline " Modelines are insecure
set expandtab " Tab expands to spaces
set tabstop=4 " Tabs are 4 spaces
set shiftwidth=4 " Indenting (< and >) is done in 4 space increments
set ignorecase " Searching is case-insensitive
set smartcase " unless the query has a capital letter
set splitright splitbelow
set noswapfile nobackup noundofile
set title
set sidescrolloff=5
set updatetime=300
set diffopt+=vertical " Always use vertical splits for diff
set number " Show line number on current line
set nowrap " Wrapping is annoying
set showmatch " Show matching brackets
set matchtime=1 " Cursor restores after highlighting matching bracket in 0.1 seconds
set signcolumn=yes " Always show the side column
set list
set listchars=trail:~,tab:>-
set completeopt-=preview
set completeopt+=menuone
set matchpairs+=<:> " Enable matching between < and >
set cursorline " Highlight cursor line
au WinEnter * ++nested setl cursorline<
au WinLeave * ++nested setl nocursorline

" Statusline
func! TerminalBufferName()
    if has('nvim')
        " In neovim, terminal filenames have the form: term://PWD//PID:CMD
        " We want to return the command name
        return '!' . join(split(bufname(), ':')[2:], ':')
    else
        " In vim, terminal buffer names are good as is
        return bufname()
    end
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

" Increase history limit
if has('shada')
    set shada=!,'1000,<50,s10,h
endif

" Use space as the leader key
let mapleader = ' '

" Make it so that Alt-Shift-J splits lines (and removes trailing whitespace)
nnoremap <silent> <M-J> i<CR><Esc>k<Cmd>s/\s\+$//e<CR>+

" Useful for quickly opening another file in the current directory
cabbrev <expr> %% expand('%:h')

if has('nvim')
    au TermOpen * ++nested setl nonu scl=no mps= nolist
    au TermEnter * ++nested setl nocul
    au TermLeave * ++nested setl cul<
endif

" Try to use ripgrep as grep program
if executable('rg')
    " Taken from https://github.com/BurntSushi/ripgrep/issues/425
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Autoformat options for markdown files
au FileType markdown ++nested setl spell tw=120 fo+=aw fo-=c

" Filetype support for direnv files
au BufRead,BufNewFile .envrc ++nested setl ft=bash

" PLUGINS
if exists('g:load_plugins') && g:load_plugins
    call plug#begin()
    Plug 'airblade/vim-gitgutter'
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-plug'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tomasiser/vim-code-dark'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'voldikss/vim-floaterm'
    Plug 'wellle/targets.vim'
    Plug 'freeo/vim-kalisi'

    " Neovim-only plugins
    if has('nvim')
        Plug 'Mofiqul/vscode.nvim'
        Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-treesitter/playground'
        Plug 'projekt0n/github-nvim-theme'
        Plug 'willcassella/nvim-gn', {'do': ':TSUpdate'}
        let g:indent_blankline_disable_with_nolist = v:true
    endif
    call plug#end()

    if has('nvim')
        luafile $HOME/config/neovim/treesitter.lua
    endif

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

    " Floaterm
    let g:floaterm_width = 0.8
    let g:floaterm_height = 0.8
    nnoremap <silent> ` <Cmd>FloatermToggle<CR>
    au FileType floaterm ++nested tnoremap <buffer><silent> ` <Cmd>FloatermToggle<CR>
    au FileType floaterm ++nested tnoremap <buffer> <C-\>` `

    " Create FZF rule for branch files
    fu s:FZFBranchFiles()
        let l:args = {'source': 'git diff --diff-filter=AMRC --name-only @{u}', 'options': '--multi'}
        call fzf#run(fzf#vim#with_preview(fzf#wrap(l:args)))
    endf
    nnoremap <silent> <leader>w <cmd>call <sid>FZFBranchFiles()<cr>

    " Make the fugitive window the only window if vim started that way.
    " ie: nvim +G
    fu s:FullscreenFugitive()
        " If current layout is two buffers: default and fugitive
        if map(getbufinfo(), 'v:val["bufnr"]') == [1, 2] && bufname(1) == "" && getbufvar(2, "&ft") == "fugitive"
            " Assume fugitive is the currently active window
            wincmd o
        endif
    endf
    au VimEnter * ++nested call s:FullscreenFugitive()
endif

" Load project vimrc files (no-op if not defined)
" I prefer this over 'use vim' in .envrc since it's more predictable
" (run once, unconditionally).
for file in split($PROJECT_VIMRC, ':')
    if len(file)
        exe 'source' file
    endif
endfor
