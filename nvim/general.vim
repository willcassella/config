" Helper function for reporting errors for plugin bindings
function PluginError(key, plugin)
    call ErrorMsg(a:key . ' not available, plugins not loaded (requires ' . a:plugin . ')', 1)
endfunction


" GENERAL OPTIONS

set nocompatible
set modelines=0 " Something to do with security
set encoding=utf-8 " Make vim always encode in utf8

set expandtab " Tab expands to spaces
set tabstop=4 " Tabs are 4 spaces
set softtabstop=4 " Soft tabs are 4 spaces
set shiftwidth=4 " Indenting (< and >) is done in 4 space increments

set autoindent " Copy indention from previous line

set ignorecase " Searching is case-insensitive
set smartcase " unless the query has a capital letter

set noequalalways " Prevent vim from resizing non-adjacent windows when opening or closing windows
set splitbelow " Horizontal splits are made below the current buffer
set splitright " Vertical spltis are made to the right of the current buffer

set autoread " Reload file if changed on-disk
set hidden " Allow closing (hiding) buffers even if they have changes

set gdefault " Make it so that g flag in replacements isn't necessary

" Show next 3 lines while scrolling
if !&scrolloff
    set scrolloff=3
endif
" Show next 5 columns while side-scrolling
if !&sidescrolloff
    set sidescrolloff=5
endif

" Only use mouse in normal and visual modes, if available
if has('mouse')
    set mouse=nv
endif

" Use system clipboard by default
set clipboard=unnamedplus

" Always use vertical splits for diff
set diffopt+=vertical


" BASIC MAPPINGS

" Use space as the leader key
let mapleader=' '

" Make it so that Alt+o and Alt+O give you whitespace in normal and insert mode
nnoremap <M-o> o<Esc>0D
nnoremap <M-O> O<Esc>0D
inoremap <M-o> <C-O>o
inoremap <M-O> <C-O>O

" Make it so that ( and ) open and close splits
nnoremap ( zo
nnoremap ) zc

" Make it so that Backslash acts like ^, since ^ is to hard to reach (go to first non-whitespace character on line)
" NOTE: I'd prefer Tab, but Ctrl-I is indistinguishable from Tab, and already does something useful
nnoremap \ ^
vnoremap \ ^

" Make it so that Backspace acts like g_ (go to last non-whitespace character)
nnoremap <BS> g_
vnoremap <BS> g_

" Make it so that - acts like $ (go to end of line)
nnoremap - $
vnoremap - $

" Make it so that _ acts like - (go to first non-whitespace character of previous visual line)
nnoremap _ k^
vnoremap _ k^

" Make it so that + works with visual lines (go to first non-whitespace character of next line)
nnoremap + jg_
vnoremap + jg_

" Make it so that CR acts like G (go to line #, default EOF)
nnoremap <CR> G
vnoremap <CR> G

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

" Make it so that Alt-Shift-j and Alt-Shift-k join and split lines
nnoremap <M-J> J
nnoremap <M-K> i<CR><Esc>

" Use Q to execute default register (used to be Q-ex mode)
nnoremap Q @q

" Make it so that double-tapping space hides search hightlights
nnoremap <silent> <leader><space> :noh<CR><Esc>
vnoremap <silent> <leader><space> :noh<CR><Esc>

" Make it so that in insert mode, Ctrl-jk can be used for autocomplete
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

" Make it so that Ctrl Backspace works like it does in most other editors (erase previous word)
inoremap <C-_> <C-W>
cnoremap <C-_> <C-W>

if g:plugins_loaded
    nnoremap <silent> <leader>* :ArgWrap<CR>
else
    nnoremap <leader>* :call PluginError('\*', 'foosoft/vim-argwrap')<CR>
    nnoremap ys :call PluginError('n_ys', 'tpope/vim-surround')<CR>
    nnoremap cs :call PluginError('n_cs', 'tpope/vim-surround')<CR>
    nnoremap ds :call PluginError('n_ds', 'tpope/vim-surround')<CR>
    vnoremap S :call PluginError('v_S', 'tpope/vim-surround')<CR>
    nnoremap s :call PluginError('n_s', 'justinmk/vim-sneak')<CR>
endif

" Create command for markdown (I use this one a lot!)
command MD set filetype=markdown | setlocal wrap


" WINDOW NAVIGATION

" Make it so that Ctrl-hjkl can be used to navigate between windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Make it so that Ctrl-Alt-hjkl can resize windows
nnoremap <C-M-H> <C-W><
nnoremap <C-M-J> <C-W>-
nnoremap <C-M-K> <C-W>+
nnoremap <C-M-L> <C-W>>


" BUFFER/TAB NAVIGATION

" Make it so that Shift-j and Shift-k can scroll the window in normal and visual modes
nnoremap J <C-E>
vnoremap J <C-E>
nnoremap K <C-Y>
vnoremap K <C-Y>

function NextTabOrBuffer()
    if tabpagenr('$') == 1
        bn
    else
        normal! gt
    endif
endfunction

function PrevTabOrBuffer()
    if tabpagenr('$') == 1
        bp
    else
        normal! gT
    endif
endfunction

" Make it so that Shift-h and Shift-l switch tabs or buffers
nnoremap <silent> H :call PrevTabOrBuffer()<CR>
nnoremap <silent> L :call NextTabOrBuffer()<CR>

" Make it so that Alt-Shift-h and Alt-Shift-l move the current tab
nnoremap <silent> <M-H> :tabmove -<CR>
nnoremap <silent> <M-L> :tabmove +<CR>

" Make it so that Ctrl-s opens the alternate buffer
nnoremap <C-S> <C-^>

if g:plugins_loaded
    " Make it so that Ctrl-e enters 'explore' mode
    nnoremap <silent> <C-E> :NERDTreeToggle<CR>

    " Make it so that Ctrl-d lets you search buffers
    nnoremap <silent> <C-D> :CtrlPBuffer<CR>

    " Make it so that Ctrl-f uses FZF plugin
    nnoremap <silent> <C-F> :FZF<CR>

    " Make it so that Ctrl-g lets you search most recently used files
    nnoremap <silent> <C-G> :CtrlPMRUFiles<CR>
else
    nnoremap <C-D> :call PluginError('Ctrl-d', 'ctrlpvim/ctrlp.vim')<CR>
    nnoremap <C-F> :call PluginError('Ctrl-f', 'ctrlpvim/ctrlp.vim')<CR>
    nnoremap <C-G> :call PluginError('Ctrl-g', 'ctrlpvim/ctrlp.vim')<CR>

    " If NERDTree isn't available, use default explorer plugin instead
    nnoremap <silent> <C-E> :Explore<CR>
endif


" BUFFER/WINDOW MANAGEMENT

function KillWindow()
    " If this is the only window open, quit vim
    if tabpagenr('$') == 1 && winnr('$') == 1
        confirm quit
        return
    endif

    " If this is the only window referencing this buffer, delete the buffer
    let bufinfo = getbufinfo({'bufnr':bufnr('%')})
    if len(bufinfo[0].windows) == 1
        confirm bdelete
        return
    endif

    " Otherwise, hide the window
    hide
endfunction

" Make it so that Ctrl-q quits the current buffer and window
nnoremap <silent> <C-Q> :call KillWindow()<CR>

" Make it so that Ctrl-Alt-q quits the current buffer and window without having to save
nnoremap <silent> <C-M-Q> :q!<CR>

if g:plugins_loaded
    " Make it so that Alt-q lets you close the current buffer without closing the window
    nnoremap <M-q> :BD<CR>

    " Make it so that Alt-Shift-q lets you close the buffer (without saving) without closing the window
    nnoremap <M-Q> :BD!<CR>
else
    nnoremap <M-q> :call PluginError('Alt-q', 'qpkorr/vim-bufkill')<CR>
    nnoremap <M-Q> :call PluginError('Alt-Shift-q', 'qpkorr/vim-bufkill')<CR>
endif

function SplitImpl()
    " If this is the header file
    if expand('%:e') == 'h'
        vsplit %:r.cc
    elseif expand('%:e') == 'cc'
        vsplit
        wincmd h
        edit %:r.h
    endif
endfunction

nnoremap <F2> :call SplitImpl()<CR>


" TERMINAL CONFIG

" Check if fish shell is available and if so, use that
let fish_path = system('command -v fish | tr -d \\n')
if v:shell_error == 0 && strlen(fish_path)
    let &shell=fish_path
endif

if has('nvim') || has('terminal')
    " Use Ctrl-\ to escape terminal mode
    tnoremap <C-\><C-C> <C-\><C-N>
    tnoremap <C-\><C-[> <C-\><C-N>
    tnoremap <C-\><Esc> <C-\><C-N>

    " Helper function for setting terminal options
    function ConfigureTerminal()
        setlocal nonumber
        setlocal norelativenumber
        setlocal scrolloff=0
    endfunction

    if has('nvim')
        autocmd TermOpen * call ConfigureTerminal()
    else
        autocmd BufWinEnter * if &buftype == 'terminal' | call ConfigureTerminal() | endif
    endif

    " Command for opening terminal in the current window
    command Term enew | call termopen(&shell)

    " Command for opening terminal in new horizontal split
    command HTerm new | call termopen(&shell)

    " Command for opening terminal in new vertical split
    command VTerm vnew | call termopen(&shell)

    " Command for opening a terminal in a new tab
    command TTerm tabnew | call termopen(&shell)
endif
