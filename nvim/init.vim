" GENERAL
set nocompatible
set number " Show line numbers
set cursorline " Highlight cursor line
set nowrap " Wrapping is annoying

set showmatch " Show matching brackets
set matchtime=1 " Cursor restores after highlighting matching bracking in .1 seconds

set expandtab " Tab expands to spaces
set tabstop=4 " Tabs are 4 spaces
set shiftwidth=4 " Indenting (< and >) is done in 4 space increments

set ignorecase " Searching is case-insensitive
set smartcase " unless the query has a capital letter

set splitbelow " Horizontal splits are made below the current buffer
set splitright " Vertical spltis are made to the right of the current buffer

" Show next 3 lines while scrolling
if !&scrolloff
    set scrolloff=3
endif
" Show next 5 columns while side-scrolling
if !&sidescrolloff
    set sidescrolloff=5
endif

" BASIC MAPPINGS
" Make space an alias for <Leader>
map <SPACE> <Leader>

" Make it so that o and O don't enter insert mode, and give you a blank line
nnoremap o o<Esc>0D
nnoremap O O<Esc>0D

" Set up <Leader>o and <Leader>O to give you "intelligent new lines"
nmap <Leader>o A<CR>
nmap <Leader>O kA<CR>

" Make it so that Tab acts like ^, since ^ is to hard to reach
nnoremap <Tab> ^
vnoremap <Tab> ^

" Make it so that <Leader>Tab acts like g_
nnoremap <Leader><Tab> g_
vnoremap <Leader><Tab> g_

" Add mappings for moving lines with alt+k/alt+j
nnoremap <A-k> :m .-2<CR>
nnoremap <A-j> :m .+1<CR>
inoremap <A-j> <Esc>:m .+1<CR>gi
inoremap <A-k> <Esc>:m .-2<CR>gi
vnoremap <A-j> :m '>+1<CR>gv
vnoremap <A-k> :m '<-2<CR>gv

" Make it so that <A-h> and <A-l> indent and outdent in all modes
" Note: Not using << here because it doesn't seem to maintain cursor position, which is annoying
nnoremap <A-h> a<C-d><Esc>
nnoremap <A-l> a<C-t><Esc>
inoremap <A-h> <C-d>
inoremap <A-l> <C-t>
vnoremap <A-h> <gv
vnoremap <A-l> >gv

" Make it so that CTRL+hjkl can be used to navigate between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make it so that J and K can scroll the window
nnoremap J <C-e>
vnoremap J <C-e>
nnoremap K <C-y>
vnoremap K <C-y>

" Make it so that H and L switch tabs
nnoremap H gT
nnoremap L gt

" Make it so that F1 can be used for doc search
nnoremap <F1> K

" Make it so that Alt+J/K join and split lines
nnoremap <A-J> J
nnoremap <A-K> i<CR><Esc>

" Make is so that Ctrl+Alt+hjkl can resize windows
nnoremap <C-M-H> <C-w><
nnoremap <C-M-J> <C-w>-
nnoremap <C-M-K> <C-w>+
nnoremap <C-M-L> <C-w>>

" Use Q to execute default register (used to be Q-ex mode)
nnoremap Q @q

" Make it so that <Esc> in terminal mode leaves terminal mode
tmap <Esc> <C-\><C-n>

" Make it so that escape in normal mode hides search hightlights
nnoremap <Esc> :noh<CR><Esc>

" Setup <Leader>i macro to create two blank lines and insert
map <Leader>i oOi

" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'Yggdroot/indentline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'equalsraf/neovim-gui-shim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
call plug#end()

" PLUGIN MAPPINGS
map <C-n> :NERDTreeToggle<CR>
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
map <Leader> <Plug>(easymotion-bd-w)
nmap <Leader> <Plug>(easymotion-overwin-w)

" Plugin customization
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
let g:gitgutter_sign_modified_removed = '|'

" THEMES
syntax on " Enable themes
set termguicolors " Enable true color mode
let g:airline_powerline_fonts=1
let g:airline_theme='onedark'
silent! colorscheme onedark

