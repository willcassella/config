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
set nocompatible
set nomodeline " Modelines are insecure
set encoding=utf-8 " Make vim always encode in utf8
set expandtab " Tab expands to spaces
set tabstop=4 " Tabs are 4 spaces
set softtabstop=4 " Soft tabs are 4 spaces
set shiftwidth=4 " Indenting (< and >) is done in 4 space increments
set autoindent " Copy indention from previous line
set ignorecase " Searching is case-insensitive
set smartcase " unless the query has a capital letter
set autoread " Reload file if changed on-disk
set hidden " Allow closing (hiding) buffers even if they have changes

set gdefault " Make it so that g flag in replacements isn't necessary

set scroll=20
set scrolloff=2
set sidescrolloff=5

if exists('&inccommand')
    set inccommand=nosplit " Show command results incrementally
endif

set updatetime=300

if has('mouse')
    set mouse=a
endif

set clipboard=unnamed,unnamedplus " Use system clipboard by default

set diffopt+=vertical " Always use vertical splits for diff

syntax on " Enable syntax highlighting

set number " Show line number on current line
set cursorline " Highlight cursor line
set nowrap " Wrapping is annoying

set showmatch " Show matching brackets
set matchtime=1 " Cursor restores after highlighting matching bracket in 0.1 seconds

set signcolumn=yes " Always show the side column

set list
set listchars=trail:-

set completeopt-=preview " Showing information in the preview window is annoying
set completeopt+=menuone

set matchpairs+=<:> " Enable matching between < and >

" Use space as the leader key
let mapleader = ' '


" PLUGINS
if g:load_plugins
    call plug#begin()
    Plug 'junegunn/vim-plug'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'
    Plug 'lifepillar/vim-solarized8'
    Plug 'arcticicestudio/nord-vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'airblade/vim-gitgutter'
    Plug 'ryanoasis/vim-devicons', g:pretty ? {} : {'on': []}
    Plug 'qpkorr/vim-bufkill'
    Plug 'justinmk/vim-sneak'
    Plug 'wellle/targets.vim'
    Plug 'svermeulen/vim-easyclip'
    Plug 'foosoft/vim-argwrap'
    Plug 'junegunn/fzf'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'willcassella/minimal_gdb'
    Plug 'skywind3000/vim-quickui'
    Plug 'psliwka/vim-smoothie'
    call plug#end()

    " BUFFKILL
    let g:BufKillActionWhenModifiedFileToBeKilled = 'confirm'

    " CTRLP
    let g:ctrlp_switch_buffer = ''

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

    if exists('*CocActionAsync')
        autocmd CursorHold * call CocActionAsync('highlight')
    endif
else
    autocmd VimEnter * call s:WarningMsg('Note: Plugins not loaded (not enabled)')

    " Errors for argwrap commands
    nnoremap <leader>* :call PluginError('\*')<CR>

    " Errors for vim-surround commands
    nnoremap ys :call PluginError('n_ys', 'tpope/vim-surround')<CR>
    nnoremap cs :call PluginError('n_cs', 'tpope/vim-surround')<CR>
    nnoremap ds :call PluginError('n_ds', 'tpope/vim-surround')<CR>
    vnoremap S :call PluginError('v_S', 'tpope/vim-surround')<CR>
    nnoremap s :call PluginError('n_s', 'justinmk/vim-sneak')<CR>

    " Errors for intellisense commands
    nnoremap [e :call PluginError('[e', 'neoclide/coc.nvim')<CR>
    nnoremap ]e :call PluginError(']e', 'neoclide/coc.nvim')<CR>
    nnoremap gd :call PluginError('gd', 'neoclide/coc.nvim')<CR>
    nnoremap gr :call Pluginerror('gr', 'neoclide/coc.nvim')<CR>
    nnoremap gi :call PluginError('gi', 'neoclide/coc.nvim')<CR>
    nnoremap <C-S> :call PluginError('Ctrl-S', 'neoclide/coc.nvim')<CR>
    nnoremap <C-Space> :call PluginError('Ctrl-Space', 'neoclide/coc.nvim')<CR>
endif

" VISUAL SETTINGS
if g:load_plugins && g:pretty
    if exists('&termguicolors')
        set termguicolors
    endif

    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'onedark'
    colorscheme onedark

    let g:gitgutter_sign_priority = 5
    let g:gitgutter_sign_added = '┃'
    let g:gitgutter_sign_modified = '╏'
    let g:gitgutter_sign_modified_removed = '╏'
    let g:gitgutter_sign_removed = '┇'

    let g:airline#extensions#fugitiveline#enabled = 1
    let g:airline#extensions#hunks#non_zero_only = 1
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_splits = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '┃'
    let g:airline#extensions#tabline#right_sep = ' '
    let g:airline#extensions#tabline#right_alt_sep = '┃'

    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
elseif g:load_plugins " (plugins, not pretty)
    let g:airline_theme = 'minimalist'

    if $TERM != "cygwin"
        silent! colorscheme onedark
    else
        colorscheme slate
    endif

    let g:gitgutter_sign_added = '++'
    let g:gitgutter_sign_modified = '~~'
    let g:gitgutter_sign_modified_removed = '~~'
    let g:gitgutter_sign_removed = '--'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#right_sep = ' '
    let g:airline#extensions#tabline#right_alt_sep = '|'
elseif g:pretty " (pretty, no plugins)
    if exists('&termguicolors')
        set termguicolors
    endif

    silent! colorscheme slate
else " (not pretty, no plugins)
    silent! colorscheme desert
endif


" BASIC MAPPINGS
" Trying to break the habit of using Ctrl-C for ESC
inoremap <C-C> <nop>

" Use <Ctrl-G> as escape
nnoremap <C-G> <ESC>
inoremap <C-G> <ESC>
vnoremap <C-G> <ESC>
cnoremap <C-G> <ESC>
onoremap <C-G> <ESC>

" Unmap <C-G> from surround.vim
" autocmd SourcePost */vim-surround/plugin/surround.vim iunmap <C-G>s
" autocmd SourcePost */vim-surround/plugin/surround.vim iunmap <C-G>S

" Make it so that Ctrl-U does redo (Ctrl-R is for scrolling)
nnoremap <C-U> <C-R>
if g:load_plugins
    nmap <C-U> <Plug>(RepeatRedo)
endif

" Make it so that Backslash acts like ^, since ^ is to hard to reach (go to first non-whitespace character on line)
nnoremap \ ^
vnoremap \ ^

" Make it so that Backspace acts like g_ (go to last non-whitespace character)
nnoremap <BS> g_
vnoremap <BS> g_

" Make it so that - acts like $ (go to end of line)
nnoremap - $
vnoremap - $

" Make it so that _ acts like - (go to first non-whitespace character of previous line)
nnoremap _ -
vnoremap _ -

" Add mappings for moving lines with alt+k/alt+j
nnoremap <M-k> :m .-2<CR>
nnoremap <M-j> :m .+1<CR>
inoremap <M-j> <Esc>:m .+1<CR>gi
inoremap <M-k> <Esc>:m .-2<CR>gi
vnoremap <M-j> :m '>+1<CR>gv
vnoremap <M-k> :m '<-2<CR>gv

" Make it so that <A-h> and <A-l> indent and outdent in all modes
" Note: Not using << here because it doesn't seem to maintain cursor position, which is annoying
nnoremap <M-h> a<C-d><Esc>
nnoremap <M-l> a<C-t><Esc>
inoremap <M-h> <C-d>
inoremap <M-l> <C-t>
vnoremap <M-h> <gv
vnoremap <M-l> >gv

" Make it so that F1 can be used for doc search
nnoremap <F1> K

" Make it so that Shift-k splits lines
nnoremap K i<CR><Esc>

" Use Q to execute default register (used to be Q-ex mode)
nnoremap Q @q

" Make it so that double-tapping space hides search highlights
nnoremap <silent> <leader><space> :noh<CR><Esc>
vnoremap <silent> <leader><space> <ESC>:noh<CR><Esc>gv

" Make it so that Ctrl Backspace works like it does in most other editors (erase previous word)
inoremap <C-_> <C-W>
cnoremap <C-_> <C-W>

" Use <C-E>/<C-D>/<C-R>/<C-F> for scrolling
noremap <C-E> <C-U>
noremap <C-D> <C-D>
noremap <C-R> <C-Y>
noremap <C-F> <C-E>
if g:load_plugins
    let g:smoothie_no_default_mappings = v:true
    map <C-E> <Plug>(SmoothieUpwards)
    map <C-D> <Plug>(SmoothieDownwards)
    map <PageUp> <Plug>(SmoothieBackwards)
    map <S-Up> <Plug>(SmoothieBackwards)
    map <C-B> <Plug>(SmoothieBackwards)
    map <PageDown> <Plug>(SmoothieForwards)
    map <S-Down> <Plug>(SmoothieForwards)
endif


" BUFFER/TAB NAVIGATION

" Make it so that Shift-h and Shift-l switch tabs
nnoremap H gT
nnoremap L gt

" Make it so that Alt-Shift-h and Alt-Shift-l move the current tab
nnoremap <silent> <M-H> :tabmove -<CR>
nnoremap <silent> <M-L> :tabmove +<CR>

" Make it so that Ctrl-Y opens the alternate buffer
nnoremap <C-Y> <C-^>

if g:load_plugins
    " Make it so that Leader-f searches files with FZF
    nnoremap <silent> <leader>f :FZF<CR>
    " Make it so that Leader-d lets you search buffers
    nnoremap <silent> <leader>d :CtrlPBuffer<CR>
    " Make it so that Leader-g lets you search most recently used files
    nnoremap <silent> <leader>g :CtrlPMRUFiles<CR>
else
    nnoremap <leader>f :call s:PluginError('leader-f')<CR>
    nnoremap <leader>d :call s:PluginError('leader-d')<CR>
    nnoremap <leader>g :call s:PluginError('leader-g')<CR>
endif

" Function to swap between header/source files
function SwapImpl()
    " If this is the header file
    if expand('%:e') == 'h'
        edit %:r.cc
    elseif expand('%:e') == 'cc'
        edit %:r.h
    endif
endfunction

nnoremap <silent> <F2> :call SwapImpl()<CR>


" TERMINAL CONFIG

if has('nvim')
    " Use Ctrl-\ to escape terminal mode
    tnoremap <C-\><C-G> <C-\><C-N>
    tnoremap <C-\><C-[> <C-\><C-N>
    tnoremap <C-\><Esc> <C-\><C-N>

    " Helper function for setting terminal options
    function ConfigureTerminal()
        setlocal scrolloff=0
        setlocal nonumber
        setlocal signcolumn=no
        setlocal matchpairs=
    endfunction

    function UnConfigureTerminal()
        set scrolloff=2
    endfunction

    autocmd BufEnter,TermOpen * if &buftype == 'terminal' | call ConfigureTerminal() | endif
    autocmd BufLeave * if &buftype == 'terminal' | call UnConfigureTerminal() | endif
endif
