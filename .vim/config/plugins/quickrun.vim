
" quickrun{{{
let g:quickrun_config = {}
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
      \   'command':   'rst2html',
      \   'runner':    'vimproc',
      \   'outputter':    'browser',
      \}

" watchdogs.vim
let s:watchdogs_config = {}
let s:watchdogs_config['_'] = {
      \ 'hook/u_nya_/enable': 1,
      \ 'hook/unite_quickfix/enable_failure': 1,
      \}

let s:watchdogs_config = {
      \ 'watchdogs_checker/ghc-mod': {
      \ 'command': 'ghc-mod',
      \ 'exec':    '%c %o --hlintOpt="--language=XmlSyntax" check %s:p',
      \ },
      \
      \ 'haskell/watchdogs_checker': {
      \ 'type': 'watchdogs_checker/ghc-mod',
      \ },
      \}
let s:watchdogs_config['watchdogs_checker/gjslint'] = {
      \ 'command'   : 'gjslint',
      \ 'exec'      : '%c %s:p ',
      \}
let s:watchdogs_config["javascript/watchdogs_checker"] = {
      \ "type" : "watchdogs_checker/gjslint",
      \}

let g:watchdogs_check_BufWritePost_enables = {
      \ "haskell" : 1
      \}

call extend(g:quickrun_config, s:watchdogs_config)
call watchdogs#setup(g:quickrun_config)

"}}}
