" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'yggdroot/indentline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'ryanoasis/vim-devicons', g:pretty ? {} : { 'on': [] }
Plug 'qpkorr/vim-bufkill'
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'svermeulen/vim-easyclip'
Plug 'foosoft/vim-argwrap'
call plug#end()


" PLUGIN CUSTOMIZATION
let g:deoplete#enable_at_startup = 1

" Autocomplete
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

let g:indentLine_bufTypeExclude = ['help', 'terminal']

let g:BufKillActionWhenModifiedFileToBeKilled = 'confirm'

let g:plugins_loaded = 1
