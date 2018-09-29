" Helper function for printing warning messages
function WarningMsg(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction

" Helper function for printing error messages without throwing an exception
function ErrorMsg(msg, bell)
    if a:bell
        exec 'normal! \<Esc>'
    endif

    echohl ErrorMsg
    echomsg a:msg
    echohl None
endfunction

" Set default option values
if !exists('g:load_plugins')
    let g:load_plugins = 0
endif

if !exists('g:pretty')
    let g:pretty = 0
endif

" Load sub-files
if g:load_plugins
    exec 'source ' . g:config_path . '/plugins.vim'
else
    let g:plugins_loaded = 0
    autocmd VimEnter * call WarningMsg('Plugins not loaded, plugins have been disabled (g:load_plugins=0)')
endif

exec 'source ' . g:config_path . '/general.vim'
exec 'source ' . g:config_path . '/appearance.vim'
