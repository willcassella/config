if !exists('g:load_plugins')
    let g:load_plugins = 0
endif

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
set ruler
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
set scrolloff=2
set sidescrolloff=5
set updatetime=300
set diffopt+=vertical " Always use vertical splits for diff
set number " Show line number on current line
set cursorline " Highlight cursor line
set nowrap " Wrapping is annoying
set showmatch " Show matching brackets
set matchtime=1 " Cursor restores after highlighting matching bracket in 0.1 seconds
set signcolumn=yes " Always show the side column
set list
set listchars=trail:~,tab:>-
set completeopt-=preview
set completeopt+=menuone
set matchpairs+=<:> " Enable matching between < and >

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
nnoremap <M-k> :m .-2<CR>
nnoremap <M-j> :m .+1<CR>
inoremap <M-j> <Esc>:m .+1<CR>gi
inoremap <M-k> <Esc>:m .-2<CR>gi
vnoremap <M-j> :m '>+1<CR>gv
vnoremap <M-k> :m '<-2<CR>gv

" Make it so that Leader-k splits lines (and removes trailing whitespace)
nnoremap <silent> <leader>k i<CR><Esc>:.-1s/\s\+$//e<CR>+

" Use Q to execute q register (used to be Q-ex mode)
nnoremap Q @q

" Make it so that double-tapping space hides search highlights
nnoremap <silent> <leader><space> :noh<CR>
vnoremap <silent> <leader><space> <ESC>:noh<CR>gv

" Use <C-F> for scrolling up (more ergonomic than <C-Y>)
noremap <C-F> <C-Y>

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

" PLUGINS
if g:load_plugins
    call plug#begin()
    Plug 'junegunn/vim-plug'
    Plug 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'
    Plug 'lifepillar/vim-solarized8'
    Plug 'itchyny/lightline.vim'
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

    " Neovim-only plugins
    if has('nvim')
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    endif
    call plug#end()

    colorscheme gruvbox

    " FZF.Vim
    nnoremap <silent> <leader>f :Files<CR>
    nnoremap <silent> <leader>d :Buffers<CR>
    nnoremap <silent> <leader>g :History<CR>

    " Lightline
    let g:lightline = {}
    let g:lightline.colorscheme = 'gruvbox'
    let g:lightline.component_function = {
        \   'gitbranch': 'FugitiveHead',
        \   'cocstatus': 'coc#status',
        \ }
    let g:lightline.active = {
        \   'left': [
        \     [ 'mode', 'paste' ],
        \     [ 'gitbranch', 'readonly', 'filename', 'modified' ],
        \     [ 'cocstatus' ],
        \   ],
        \   'right': [
        \     [ 'lineinfo' ],
        \     [ 'percent' ],
        \     [ 'fileformat', 'fileencoding', 'filetype' ],
        \   ],
        \ }
    let g:lightline.tabline = {
        \   'left': [[ 'tabs' ]],
        \   'right': [],
        \ }
    set noshowmode " lightline shows the current mode in the statusline

    " ARGWRAP
    nnoremap <silent> <leader>* :ArgWrap<CR>

    " Make it so that [e and ]e can navigate between CoC errors
    nmap <silent> [e <Plug>(coc-diagnostic-prev)
    nmap <silent> ]e <Plug>(coc-diagnostic-next)

    " Remap go to definition
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> gh :call CocAction('doHover')<CR>

    " Use <C-S> and <C-Space> to search for symbols
    nnoremap <C-S> :CocList symbols<CR>
    nnoremap <C-Space> :CocList outline<CR>

    " Ensure lightline is updated with coc status changes
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

    " Git gutter
    let g:gitgutter_sign_priority = 5
    let g:gitgutter_sign_added = '┃'
    let g:gitgutter_sign_modified = '╏'
    let g:gitgutter_sign_modified_removed = '╏'
    let g:gitgutter_sign_removed = '┇'

    " Floaterm
    nnoremap <silent> ` :FloatermToggle<CR>
    au FileType floaterm tnoremap <buffer><silent> ` <C-\><C-N>:FloatermToggle<CR>
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
