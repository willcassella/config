" Helper function for printing warning messages
function s:WarningMsg(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction

" Helper function for printing error messages without throwing an exception
function s:ErrorMsg(msg)
    echohl ErrorMsg
    echomsg a:msg
    echohl None
endfunction

" Helper function for reporting errors for plugin bindings
function s:PluginError(key)
    call s:ErrorMsg(a:key . ' not available, plugins not loaded', 1)
endfunction

if !exists('g:pretty')
    let g:pretty = 0
endif

if !exists('g:load_plugins')
    let g:load_plugins = 0
endif

" GENERAL OPTIONS
set nomodeline " Modelines are insecure
set laststatus=2 " Always show the statusline
set ruler
set wildmenu
set encoding=utf-8 " Make vim always encode in utf8
set expandtab " Tab expands to spaces
set tabstop=4 " Tabs are 4 spaces
set shiftwidth=4 " Indenting (< and >) is done in 4 space increments
set autoindent " Copy indention from previous line
set autoread " Reload file if changed on-disk
set hidden " Allow closing (hiding) buffers even if they have changes
set belloff=all " The bell is annoying
set backspace=start,indent,eol
set hlsearch
set incsearch
set ignorecase " Searching is case-insensitive
set smartcase " unless the query has a capital letter
set splitright splitbelow

" Increase history limit
if has('shada')
    set shada=!,'1000,<50,s10,h
endif

set scrolloff=2
set sidescrolloff=5

if exists('&inccommand')
    set inccommand=nosplit " Show command results incrementally
endif

set history=10000
set updatetime=300
set tabpagemax=50

if has('mouse')
    set mouse=a
endif

set diffopt+=vertical " Always use vertical splits for diff

set number " Show line number on current line
set cursorline " Highlight cursor line
set nowrap " Wrapping is annoying

set showmatch " Show matching brackets
set matchtime=1 " Cursor restores after highlighting matching bracket in 0.1 seconds

set signcolumn=yes " Always show the side column

set list
set listchars=trail:~

set completeopt-=preview
set completeopt+=menuone

set matchpairs+=<:> " Enable matching between < and >

" Use space as the leader key
let mapleader = ' '

syntax on
filetype plugin indent on


" PLUGINS
if g:load_plugins
    call plug#begin()
    Plug 'junegunn/vim-plug'
    Plug 'joshdick/onedark.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'morhetz/gruvbox'
    Plug 'lifepillar/vim-solarized8'
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
    call plug#end()

    " FZF.Vim
    nnoremap <silent> <leader>f :Files<CR>
    nnoremap <silent> <leader>d :Buffers<CR>
    nnoremap <silent> <leader>g :History<CR>

    " Lightline
    let g:lightline = {}
    let g:lightline.component_function = {
        \   'gitbranch': 'FugitiveHead',
        \   'cocdiagnostic': 'CocStatusDiagnostic',
        \ }
    let g:lightline.active = {
        \   'left': [
        \     [ 'mode', 'paste' ],
        \     [ 'gitbranch', 'readonly', 'filename', 'modified' ],
        \     [ 'cocdiagnostic' ],
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

    " Add CoC diagnostics to the statusline
    function! CocStatusDiagnostic() abort
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif

      let msgs = []
      if get(info, 'error', 0)
        call add(msgs, 'E' . info['error'])
      endif
      if get(info, 'warning', 0)
        call add(msgs, 'W' . info['warning'])
      endif
      return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
    endfunction

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
else
    autocmd VimEnter * call s:WarningMsg('Note: Plugins not loaded (not enabled)')

    " Errors for fzf.vim
    nnoremap <leader>f :call s:PluginError('leader-f')<CR>
    nnoremap <leader>d :call s:PluginError('leader-d')<CR>
    nnoremap <leader>g :call s:PluginError('leader-g')<CR>

    " Errors for argwrap commands
    nnoremap <leader>* :call s:PluginError('\*')<CR>

    " Errors for vim-surround commands
    nnoremap ys :call s:PluginError('n_ys')<CR>
    nnoremap cs :call s:PluginError('n_cs')<CR>
    nnoremap ds :call s:PluginError('n_ds')<CR>
    vnoremap S :call s:PluginError('v_S')<CR>

    " Errors for intellisense commands
    nnoremap [e :call s:PluginError('[e')<CR>
    nnoremap ]e :call s:PluginError(']e')<CR>
    nnoremap gd :call s:PluginError('gd')<CR>
    nnoremap gr :call s:Pluginerror('gr')<CR>
    nnoremap gh :call s:PluginError('gh')<CR>
    nnoremap <C-S> :call s:PluginError('Ctrl-S')<CR>
    nnoremap <C-Space> :call s:PluginError('Ctrl-Space')<CR>
endif

" VISUAL SETTINGS
if g:pretty && exists('&termguicolors')
    set termguicolors
endif

if g:pretty && g:load_plugins
    colorscheme gruvbox
    let g:lightline.colorscheme = 'gruvbox'
else
    colorscheme desert
endif

" Make it so that Backslash acts like ^, since ^ is to hard to reach (go to first non-whitespace character on line)
noremap \ ^

" Make it so that Backspace acts like g_ (go to last non-whitespace character)
noremap <BS> g_

" Add mappings for moving lines with alt+k/alt+j
nnoremap <M-k> :m .-2<CR>
nnoremap <M-j> :m .+1<CR>
inoremap <M-j> <Esc>:m .+1<CR>gi
inoremap <M-k> <Esc>:m .-2<CR>gi
vnoremap <M-j> :m '>+1<CR>gv
vnoremap <M-k> :m '<-2<CR>gv

" Make it so that Leader-k splits lines (and removes trailing whitespace)
nnoremap <silent> <leader>k i<CR><Esc>:.-1s/\s\+$//e<CR>+

" Use Q to execute default register (used to be Q-ex mode)
nnoremap Q @q

" Make it so that double-tapping space hides search highlights
nnoremap <silent> <leader><space> :noh<CR>
vnoremap <silent> <leader><space> <ESC>:noh<CR>gv

" Use <C-F> for scrolling up (more ergonomic than <C-Y>)
noremap <C-F> <C-Y>

" Useful for quickly opening another file in the current directory
cabbrev <expr> %% expand('%:h')

" TERMINAL CONFIG

if has('nvim')
    " Helper function for setting terminal options
    function ConfigureTerminal()
        setlocal scrolloff=0
        setlocal nonumber
        setlocal signcolumn=no
        setlocal matchpairs=
    endfunction

    function UnConfigureTerminal()
        setlocal scrolloff=2
    endfunction

    autocmd BufEnter,TermOpen * if &buftype == 'terminal' | call ConfigureTerminal() | endif
    autocmd BufLeave * if &buftype == 'terminal' | call UnConfigureTerminal() | endif
endif
