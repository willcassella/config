" GENERAL
set number " Show line numbers
set cursorline " Highlight cursor line

set showmatch " Show matching brackets
set matchtime=1 " Cursor restores after highlighting matching bracking in .1 seconds
set t_ti="" " Restore terminal contents after closing vim

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

" Make it so that o and O don't enter insert mode
nnoremap o o<Esc>
nnoremap O O<Esc>

" Make it so that Tab acts like ^, since ^ is to hard to reach
nnoremap <Tab> ^
vnoremap <Tab> ^

" Make it so that Ctrl-j and Ctrl-k move up and, retaining cursor pos in view
noremap <C-j> <C-e>j
noremap <C-k> <C-y>k

" Make it so that K splits the line at the cursor position
noremap K i<CR><Esc>

" Add mappings for moving lines with alt+k/alt+j
nnoremap <A-k> :m .-2<CR>==
nnoremap <A-j> :m .+1<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Make it so that <A-h> and <A-l> indent and outdent in all modes
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-h> <Esc><<gi
inoremap <A-l> <Esc>>>gi
vnoremap <A-h> <gv
vnoremap <A-l> >gv

" Use Q to execute default register (used to be Q-ex mode)
nnoremap Q @q

" Make it so that <Esc> in terminal mode leaves terminal mode
tmap <Esc> <C-\><C-n>

" LEADER MAPPINGS
" Setup <Leader>i macro to create two blank lines and insert
map <Leader>i oOi
" Make <Leader>a disable highlighted text from search (inspired by Blender)
map <silent> <Leader>a :noh<CR>
" Make <Leader>` open a console below the current buffer
nmap <Leader>` :10sp term://bash<CR>

" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'Yggdroot/indentline'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'equalsraf/neovim-gui-shim'
Plug 'scrooloose/nerdtree'
call plug#end()

" PLUGIN MAPPINGS
map <C-n> :NERDTreeToggle<CR>

" THEMES
syntax on " Enable themes
set termguicolors " Enable true color mode
let g:airline_powerline_fonts=1
let g:airline_theme='onedark'
colorscheme onedark

