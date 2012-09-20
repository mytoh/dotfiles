
" quickrun{{{
let g:quickrun_config = {}
let g:quickrun_config['scheme.scss'] = {
      \   'command':   '/usr/local/bin/scss2css',
      \   'exec':      ['%c %s'],
      \   'shebang':   0,
      \   'outputter': 'file_scss',
      \   'runner':    'vimproc',
      \}
let g:quickrun_config['cobol'] = {
      \   'command':   'cobc',
      \   'exec':      ['%c -x %s'],
      \   'shebang':   0,
      \   'runner':    'vimproc',
      \}

let g:quickrun_config['rst'] = {
      \   'command':   'rst2html',
      \   'runner':    'vimproc',
      \   'outputter':    'browser',
      \}
"}}}
