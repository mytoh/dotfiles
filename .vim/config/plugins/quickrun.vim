
" quickrun{{{
let g:quickrun_config = {}
let g:quickrun_config['_'] = {
      \ 'outputter': 'multi:buffer:quickfix',
      \ 'outputter/buffer/split': ':botright 8sp',
      \ 'runner': 'vimproc',
      \ 'runner/vimproc/updatetime': 40,
      \}
let g:quickrun_config.scss = {
      \   'command':   '/usr/local/bin/scss2css',
      \   'exec':      ['%c %s'],
      \   'shebang':   0,
      \   'outputter': 'file_scss',
      \   'runner':    'vimproc',
      \}
let g:quickrun_config.cobol = {
      \   'command':   'cobc',
      \   'exec':      ['%c -x %s'],
      \   'shebang':   0,
      \   'runner':    'vimproc',
      \}

let g:quickrun_config.rst = {
      \   'command':   'rst2html.py',
      \   'runner':    'vimproc',
      \}

let g:quickrun_config['scheme.test'] = {
      \   'command':   'pieni',
      \   'shebang':   0,
      \   'runner':    'vimproc',
      \}

" watchdogs.vim
let s:watchdogs_config = {}

let s:watchdogs_config['watchdogs_checker/_'] = {
      \ 'hook/copen/enable_exist_data': 1,
      \ 'hook/u_nya_/enable': 1,
      \ 'hook/close_unite_quickfix/enable_hook_loaded': 1,
      \ 'hook/unite_quickfix/enable_failure': 1,
      \ 'hook/close_quickfix/enable_exit': 1,
      \ 'hook/close_buffer/enable_failure': 1,
      \ 'hook/close_buffer/enable_empty_data': 1,
      \}

" haskell
let s:watchdogs_config['watchdogs_checker/ghc-mod'] = {
      \ 'command': 'ghc-mod',
      \ 'cmdopt':  '--hlintOpt="--language=XmlSyntax" --ghcOpt="-i$HOME/.xmonad/lib"',
      \ 'exec':    '%c check %o %s:p',
      \ }
let s:watchdogs_config['haskell/watchdogs_checker'] = {
      \ 'type': 'watchdogs_checker/ghc-mod',
      \ }

" javascript
let s:watchdogs_config['watchdogs_checker/gjslint'] = {
      \ 'command'   : 'gjslint',
      \ 'exec'      : '%c %s:p ',
      \}
let s:watchdogs_config["javascript/watchdogs_checker"] = {
      \ "type" : "watchdogs_checker/gjslint",
      \}


" watchdog hook
let g:watchdogs_check_BufWritePost_enables = {
      \ 'haskell' : 1,
      \ 'javascript': 1,
      \}


call extend(g:quickrun_config, s:watchdogs_config)
call watchdogs#setup(g:quickrun_config)

"}}}
