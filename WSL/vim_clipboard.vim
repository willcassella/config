let g:clipboard = {
\   'name': 'wsl_clipboard',
\   'copy': {
\       '+': 'clip.exe',
\       '*': 'clip.exe',
\   },
\   'paste': {
\       '+': 'pasterboy.exe | dos2unix | dos2unix',
\       '*': 'pasterboy.exe | dos2unix | dos2unix',
\   },
\   'cache_enabled': 1,
\}
