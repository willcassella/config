" Neovim defaults (here for vim)
set nocompatible
set autoindent
set autoread
set backspace=start,indent,eol
set belloff=all
set encoding=utf-8
set hlsearch
set incsearch
set history=10000
set tabpagemax=50
set laststatus=2
set wildmenu

" GENERAL OPTIONS
set nomodeline " Modelines are insecure
set expandtab " Tab expands to spaces
set tabstop=4 " Tabs are 4 spaces
set shiftwidth=4 " Indenting (< and >) is done in 4 space increments
set hidden " Allow closing (hiding) buffers even if they have changes
set ignorecase " Searching is case-insensitive
set smartcase " unless the query has a capital letter
set splitright splitbelow
set noswapfile nobackup noundofile
set title
set scrolloff=1
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
au WinEnter * setl cursorline<
au WinLeave * setl nocursorline

" Statusline
func! StatuslineParts(parts)
    " Eval each expression in g:statusline_extra and remove empty results
    let l:results = map(copy(a:parts), 'eval(v:val)')
    call filter(l:results, 'len(v:val)')
    return trim(join([''] + l:results, ' | '))
endfunc
let g:statusline_left_parts = []
let g:statusline_right_parts = ['&fenc', '&ff', "&ft"]

func! MyStatusLine()
    " Style terminal buffers differently
    if &buftype == 'terminal' | return '%{&shell}%<%=[term]' | endif
    let l:left_part = '%t%( %m%r%)%<'
    let l:right_part = '%l/%L:%c'
    " Style non-current buffers differently
    if win_getid() != g:actual_curwin | return l:left_part . '%=' . l:right_part | endif
    " Current non-terminal buffer includes extra parts
    let l:left_part .= '%( %{StatuslineParts(g:statusline_left_parts)}%)'
    let l:right_part .= '%( %{StatuslineParts(g:statusline_right_parts)}%)'
    return l:left_part . '%=' . l:right_part
endfunc
set statusline=%{%MyStatusLine()%}

" Increase history limit
if has('shada')
    set shada=!,'1000,<50,s10,h
endif

if exists('&inccommand')
    set inccommand=nosplit " Show command results incrementally
endif

if has('mouse')
    set mouse=a
endif

syntax on
filetype plugin indent on

" Use space as the leader key
let mapleader = ' '

" Add mappings for moving lines with alt+k/alt+j
nnoremap <M-k> <Cmd>m .-2<CR>
nnoremap <M-j> <Cmd>m .+1<CR>
inoremap <M-j> <Cmd>m .+1<CR>
inoremap <M-k> <Cmd>m .-2<CR>
vnoremap <M-j> :m '>+1<CR>gv
vnoremap <M-k> :m '<-2<CR>gv

" Make it so that Leader-k splits lines (and removes trailing whitespace)
nnoremap <silent> <leader>k i<CR><Esc><Cmd>.-1s/\s\+$//e<CR>+

" Use Q to execute q register (used to be Q-ex mode)
nnoremap Q @q

" Make it so that double-tapping space hides search highlights
noremap <silent> <leader><space> <Cmd>noh<CR>

" Useful for quickly opening another file in the current directory
cabbrev <expr> %% expand('%:h')

if has('nvim')
    au TermOpen * setl nonu so=0 scl=no mps= nolist
    au TermEnter * setl nocul
    au TermLeave * setl cul<
endif

" Try to use ripgrep as grep program
if executable("rg")
    " Taken from https://github.com/BurntSushi/ripgrep/issues/425
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Autoformat options for markdown files
au FileType markdown setl spell tw=120 fo+=aw fo-=c

" Filetype support for direnv files
au BufRead,BufNewFile .envrc setl ft=bash

" Filetype support for gn files
au BufRead,BufNewFile *.gn,*.gni setl ft=gn
au FileType gn setl syn=conf ts=2 sw=2 inex=substitute(v:fname,'^//','','')

" Helper function for copying path of current buffer
com YankPath let @0=@%

" PLUGINS
if exists('g:load_plugins') && g:load_plugins
    call plug#begin()
    Plug 'junegunn/vim-plug'
    Plug 'gruvbox-community/gruvbox'
    Plug 'tomasiser/vim-code-dark'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'airblade/vim-gitgutter'
    Plug 'wellle/targets.vim'
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'voldikss/vim-floaterm'

    if executable('direnv')
        Plug 'direnv/direnv.vim'
    endif

    " Neovim-only plugins
    if has('nvim')
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    endif
    call plug#end()

    colorscheme gruvbox

    " Fugitive
    let g:statusline_left_parts += ["FugitiveHead()"]

    " FZF.Vim
    nnoremap <silent> <leader>f <Cmd>Files<CR>
    nnoremap <silent> <leader>d <Cmd>Buffers<CR>
    nnoremap <silent> <leader>g <Cmd>History<CR>

    " ARGWRAP
    nnoremap <silent> <leader>* <Cmd>ArgWrap<CR>

    " CoC
    let g:statusline_left_parts += ["coc#status()"]
    autocmd User CocStatusChange,CocDiagnosticChange let &ro = &ro

    " Make it so that [e and ]e can navigate between CoC errors
    nmap <silent> [e <Plug>(coc-diagnostic-prev)
    nmap <silent> ]e <Plug>(coc-diagnostic-next)

    " Remap go to definition
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> gh <Cmd>call CocAction('doHover')<CR>

    " User <leader>cf for Coc fix
    nnoremap <silent> <leader>cf <Cmd>CocFix<CR>

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
    nnoremap <silent> ` <Cmd>FloatermToggle<CR>
    au FileType floaterm tnoremap <buffer><silent> ` <Cmd>FloatermToggle<CR>
    au FileType floaterm tnoremap <buffer> <C-\>` `

    " Create FZF rule for branch files
    fu s:FZFBranchFiles()
        let l:args = {'source': 'git diff --diff-filter=AMRC --name-only @{u}', 'options': '--multi'}
        call fzf#run(fzf#vim#with_preview(fzf#wrap(l:args)))
    endf
    nnoremap <silent> <leader>w <cmd>call <sid>FZFBranchFiles()<cr>

    " Treesitter
    if has('nvim')
        luafile $HOME/config/neovim/treesitter.lua
    endif
else
    colorscheme desert
endif
