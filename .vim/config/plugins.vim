
if filereadable(expand('~/.vim/config/global.vim'))
  source ~/.vim/config/global.vim
endif

" plugins {{{
"
" Chalice {{{
"set runtimepath+=$HOME/.vim/chalice
let chalice_startupflags              = 'bookmark'
let chalice_writeoptions              = 'amp,nbsp,zenkaku'
let chalice_statusline                = '%c,'
let chalice_anonyname                 = ''
let chalice_boardlist_columns         = 9
let chalice_threadlist_lines          = 13
let chalice_autonumcheck              = 1
let chalice_previewflags              = 'autoclose'
let chalice_reloadinterval_threadlist = 0
let chalice_basedir                   = $HOME . '/.chalice'
let chalice_exbrowser                 = 'tmux new-window w3m %URL% '
augroup chalice
  autocmd!
  autocmd filetype 2ch_thread       CMiniBufExplorer
augroup end
"call mkdir($HOME.'/.chalice', 'p')
"}}}

" neocomplcache"{{{
let g:neocomplcache_enable_at_startup              = 1
let g:neocomplcache_enable_smart_case              = 1
let g:neocomplcache_enable_ignore_case             = 1
" let g:neocomplcache_enable_camel_case_completion = 1
" let g:neocomplcache_enable_underbar_completi on  = 1
let g:neocomplcache_enable_fuzzy_completion        = 1
let g:neocomplcache_enable_auto_select             = 1
let g:neocomplcache_use_vimproc                    = 1
let g:neocomplcache_enable_prefetch                = 1
let g:neocomplcache_max_list                       = 1000
let g:neocomplcache_dictionary_filetype_lists      = {
      \ 'default'  : '',
      \ 'scheme'   : $RLWRAP_HOME . '/gosh_completions',
      \ 'vimshell' : $HOME . '/.vimshell/command-history' }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplcache_context_filetype_lists')
  let g:neocomplcache_context_filetype_lists = {}
endif
let g:neocomplcache_context_filetype_lists.perl6 =
      \ [{'filetype' : 'pir', 'start' : 'Q:PIR\s*{', 'end' : '}'}]
let g:neocomplcache_context_filetype_lists.vim =
      \ [{'filetype' : 'python', 'start' : '^\s*python <<\s*\(\h\w*\)', 'end' : '^\1'}]
" neocomplcache key-mappings {{{
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
inoremap <expr><C-m>  neocomplcache#close_popup() . "\<CR>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
" }}}

augroup myautocommands
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" snippet directory
let g:neocomplcache_snippets_dir='~/.vim/snippets'


" force cache dict when insert
" augroup myautocommands
" autocmd InsertEnter * call s:neco_pre_cache()
" augroup end
" function! s:neco_pre_cache()
"   if exists('b:neco_pre_cache')
"     return
"   endif
"   let b:neco_pre_cache = 1
"   if bufname('%') =~ g:neocomplcache_lock_buffer_name_pattern
"     return
"   endif
"   :NeoComplCacheCachingBuffer
"   :NeoComplCacheCachingDictionary
" endfunction
"}}}

" vimfiler"{{{
" from http://d.hatena.ne.jp/hrsh7th/20120229/1330525683

" vimfiler key-mappings {{{
nnoremap [vimfiler] <nop>
nmap     <localleader>f [vimfiler]
nnoremap <silent> [vimfiler]f :<c-u>VimFiler<cr>
nnoremap <silent> [vimfiler]t :<c-u>VimFilerTab<cr>
nnoremap <silent> [vimfiler]k :<c-u>Unite bookmark:directory<cr>
nnoremap <silent> <c-e> :VimFilerExplorer <cr>
" }}}

let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_sort_type = "Time"
let g:vimfiler_edit_action = 'tabopen'

augroup vimfiler
  autocmd myautocommands filetype vimfiler call g:my_vimfiler_settings()
augroup end
function! g:my_vimfiler_settings() "{{{
  nmap     <buffer><expr><cr>        vimfiler#smart_cursor_map("\<plug>(vimfiler_expand_tree)", "\<plug>(vimfiler_edit_file)")
  nmap     <buffer> q         <plug>(vimfiler_exit)
  nmap     <buffer> Q         <plug>(vimfiler_hide)
  nnoremap <buffer><localleader><silent>s    :call vimfiler#mappings#do_action('my_split')<cr>
  nnoremap <buffer><localleader><silent>S    :call vimfiler#mappings#do_action('my_vsplit')<cr>
  call vimfiler#set_execute_file('mkv,mpg,mp4', 'mplayer')
  call vimfiler#set_execute_file('jpg,JPG,jpeg,png,gif,bmp,cbz,cbr,cbx', 'mplayer')
  if exists('*vimfiler#set_extensions')
    call vimfiler#set_extensions('archive', 'xz,txz,cbz,cbr,lzh,zip,gz,bz2,cab,rar,7z,tgz,tar')
  endif
endfunction "}}}

let my_vimfiler_split_action = { 'is_selectable' : 1, }
function! my_vimfiler_split_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
if exists('*unite#custom_action')
  call unite#custom_action('file', 'my_split', my_vimfiler_split_action)
endif
unlet my_vimfiler_split_action

let my_vimfiler_vsplit_action = { 'is_selectable' : 1, }
function! my_vimfiler_vsplit_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
if exists('*unite#custom_action')
  call unite#custom_action('file', 'my_vsplit', my_vimfiler_vsplit_action)
endif
unlet my_vimfiler_vsplit_action


" }}}

" {{{ fholgado's minibufexpl
"nnoremap gt :<c-u>MBEbn<cr>
"nnoremap gT :<c-u>MBEbp<cr>
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplShowBufNumbers = 0
"let g:miniBufExplSplitBelow = 0
"let g:statusLineText = ''
" minibufexplorer and many useful plugins
" d.hatena.ne.jp/yuroyoro/20101104/1288879591
"
"}}}

"{{{ rson's bufstat
" nnoremap <silent>gn :<c-u>bnext<cr>
" nnoremap <silent>gp :<c-u>bNext<cr>
" let g:bufstat_debug                 = 1
" let g:bufstat_surround_buffers      = '(:)'
" let g:bufstat_number_before_bufname = 0
" 
" let g:bufstat_active_hl_group = "ActiveBuffer"
" let g:bufstat_inactive_hl_group = "InactiveBuffer"

"}}}

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

" unite{{{

let g:unite_enable_start_insert=1
let g:unite_split_rule = "belowright"
" fnamemodify() format
" :help filename-modifiers
let g:unite_source_file_mru_filename_format = ''
let g:unite_source_file_mru_time_format = ''
let g:unite_cursor_line_highlight = 'uniteTabLineSel'
" let g:unite_abbr_highlight = 'TabLine'
highlight uniteTabLineSel cterm=bold   ctermbg=235

" auto session loading
" let g:unite_source_session_enable_auto_save = 1
" autocmd VimEnter * UniteSessionLoad


" unite keymappings {{{
nnoremap [unite] <Nop>
nmap     <localleader>u [unite]
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b :<c-u>Unite buffer<cr>
nnoremap <silent> [unite]c :<c-u>UniteWithCurrentDir -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]d :<c-u>Unite menu:directory<cr>
nnoremap <silent> [unite]f :<c-u>UniteWithBufferDir -buffer-name=files -prompt=%\  file file/new<CR>
nnoremap <silent> [unite]k :<c-u>Unite bookmark<cr>
" nnoremap <silent> [unite]r :<c-u>Unite launcher<cr>
nnoremap <silent> [unite]m :<c-u>Unite -buffer-name=files file_mru<cr>
nnoremap <silent> [unite]o :<c-u>Unite outline<cr>
noremap  <silent> [unite]p :<c-u>call <SID>unite_project('-start-insert')<cr>
noremap  <silent> [unite]s :<c-u>Unite ack --nogroup<cr>
nnoremap <silent> [unite]t :<c-u>Unite tab<cr>
nnoremap <silent> [unite]/ :<c-u>Unite -buffer-name=search line -start-insert<CR>
" }}}

function! s:unite_project(...)
  let opts = (a:0 ? join(a:000, ' ') : '')
  let dir  = unite#util#path2project_directory(expand('%'))
  execute 'Unite' opts 'file_rec:' . dir
endfunction

augroup unite_my_settings
autocmd  FileType unite call s:unite_my_settings()
augroup end
function! s:unite_my_settings() "{{{
  " Overwrite settings.
  imap <buffer> <c-w>     <plug>(unite_delete_backward_path)
  imap <buffer> <c-j>     <plug>(unite_exit)
  imap <buffer> <localleader><localleader>  <c-u>~/
  imap <buffer> <localleader>/  <c-u>/
  imap <buffer> <localleader>kv         <c-u>~/local/git/panna/kirjasto/kaava/
  " <C-l>: manual neocomplcache completion.
  inoremap <buffer> <C-l>  <C-x><C-u><C-p><Down>
  imap     <buffer> <c-w> <plug>(unite_delete_backward_path)
  " vimfiler
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  call unite#custom_default_action('file', 'tabopen')
  call unite#custom_default_action('bookmark', 'tabopen')
  " call unite#custom_default_action('directory', 'tabvimfiler')
  call unite#custom_default_action('directory_mru', 'vimfiler')
endfunction "}}}

" unite-menu {{{
if !exists("g:unite_source_menu_menus")
  let g:unite_source_menu_menus = {}
endif

" menu description
let s:commands = {
      \   'description' : 'directory shortcut',
      \ }
" set commands
let s:commands.candidates = {
      \   "quatre" : "VimFiler /mnt/quatre",
      \   "deskstar" : "VimFiler /mnt/deskstar",
      \   "mypassport" : "VimFiler /mnt/mypassport",
      \ }

" register function
function s:commands.map(key, value)
  return {
        \   'word' : a:key,
        \   'kind' : 'command',
        \   'action__command' : a:value,
        \ }
endfunction

let g:unite_source_menu_menus["directory"] = deepcopy(s:commands)
unlet s:commands

" }}}

" unite-launch {{{
let g:unite_launch_apps = [
      \ 'rake',
      \ 'make',
      \ 'scss2css',
      \ 'git pull',
      \ 'git push' ]
"}}}

" unite-ack {{{
highlight UniteAck cterm=bold ctermfg=19 ctermbg=205
let g:unite_source_ack_command = 'ack --nocolor'
let g:unite_source_ack_search_word_highlight = 'UniteAck'

" }}}

"}}}

" eskk{{{
if has('vim_starting')
  " let g:eskk#dictionary = {
  "       \ 'path'     : "~/.skk-jisyo",
  "       \ 'sorted'   : 0,
  "       \ 'encoding' : 'utf-8',
  "       \}
  if vimrc.P.is_mac()
    let g:eskk#large_dictionary = {
          \ 'path'     : "~/Library/Application\ Support/AquaSKK/SKK-JISYO.L",
          \ 'sorted'   : 1,
          \ 'encoding' : 'euc-jp',
          \}
  elseif vimrc.isos('freebsd')
    let g:eskk#large_dictionary = {
          \ 'path'     : "/usr/local/share/skk/SKK-JISYO.L",
          \ 'sorted'   : 1,
          \ 'encoding' : 'euc-jp',
          \}
  endif
endif

    " http://subtech.g.hatena.ne.jp/motemen/20110527/1306485690
    " in eskk config.
    " NOTE: This config remains the last character "z"
    " if g:eskk#rom_input_style is not "skk".
    autocmd myautocommands User eskk-initialize-pre call s:eskk_initial_pre()
    function! s:eskk_initial_pre() "{{{
        for [orgtable, mode] in [['rom_to_hira', 'hira'], ['rom_to_kata', 'kata']]
            let t = eskk#table#new(orgtable.'*', orgtable)
            call t.add_map('zw', 'w', 'z')
            call eskk#register_mode_table(mode, t)
        endfor
    endfunction "}}}
" " http://kstn.fc2web.com/seikana_zisyo.html
" autocmd myautocommands User eskk-initialize-pre call s:eskk_initial_pre()
" function! s:eskk_initial_pre()
"   " User can be allowed to modify
"   " eskk global variables (`g:eskk#...`)
"   " until `User eskk-initialize-pre` event.
"   " So user can do something heavy process here.
"   " (I'm a paranoia, eskk#table#new() is not so heavy.
"   " But it loads autoload/vice.vim recursively)
"   let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
"   call t.add_map('gwa', 'ぐゎ')
"   call t.add_map('gwe', 'ぐぇ')
"   call t.add_map('gwi', 'ぐぃ')
"   call t.add_map('gwo', 'ぐぉ')
"   call t.add_map('gwu', 'ぐ')
"   call t.add_map('kwa', 'くゎ')
"   call t.add_map('kwe', 'くぇ')
"   call t.add_map('kwi', 'くぃ')
"   call t.add_map('kwo', 'くぉ')
"   call t.add_map('kwu', 'く')
"   call t.add_map('we', 'ゑ')
"   call t.add_map('wha', 'うぁ')
"   call t.add_map('whe', 'うぇ')
"   call t.add_map('whi', 'うぃ')
"   call t.add_map('who', 'うぉ')
"   call t.add_map('whu', 'う')
"   call t.add_map('wi', 'ゐ')
"   call t.add_map(':',':')
"   call t.add_map(';',';')
"   call t.add_map('!','!')
"   call t.add_map('?','?')
"   call t.add_map('{','『')
"   call t.add_map('}','』')
"   call eskk#register_mode_table('hira', t)
" endfunction

let g:eskk#egg_like_newline = 1
let g:eskk#enable_completion = 1
let g:eskk#select_cand_keys = "aoeuidhts"
let g:eskk#show_annotation = 1
"let g:eskk_revert_henkan_style = "okuri"

"}}}

" vimshell {{{

let g:vimshell_user_prompt = '":: " . "(" . fnamemodify(getcwd(), ":~") . ")"'
let g:vimshell_prompt = '>> '
" let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'

"if isdirectory(expand('~/.vim/bundle/vimproc/'))
"call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
"endif

let g:vimshell_execute_file_list = {}
let g:vimshell_execute_file_list['pl'] = 'perl'
let g:vimshell_execute_file_list['scm'] = 'gosh'


let g:vimshell_enable_smart_case = 1
let g:vimshell_enable_auto_slash = 1
let g:vimshell_split_height = 20
let g:vimshell_split_command = 'split'
augroup vimshell
  autocmd!
  autocmd filetype vimshell  call vimshell#hook#set('chpwd', ['g:my_chpwd'])
  autocmd filetype vimshell  call unite#custom_default_action('vimshell/history', 'insert')
  function! g:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction
  "inoremap <buffer> <expr><silent> <C-l>  unite#sources#vimshell_history#start_complete()
  inoremap <buffer><expr> <C-l> unite#start_complete(
        \ ['vimshell/history'], {
        \ 'start_insert' : 0,
        \ 'input' : vimshell#get_cur_text()})
augroup end

" vimshell key-mappings {{{
nnoremap [vimshell] <nop>
nmap     <localleader>s [vimshell]
nmap     <silent> [vimshell]s <Plug>(vimshell_split_create)
nmap     <silent> [vimshell]c <Plug>(vimshell_create)
nnoremap <silent> [vimshell]p :<c-u>VimShellPop<cr>
nnoremap <silent> [vimshell]t :<c-u>VimShellTab<cr>
" }}}
"}}}

" gauref{{{
let g:gauref_file = $HOME . '/.bundle/gauref.vim/doc/gauche-refj.txt'
"}}}

" vim-ref {{{
"http://www.karakaram.com/vim/ref-webdict/
let g:ref_use_vimproc = 1
let g:ref_source_webdict_sites = {
      \   'je': {
      \     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
      \   },
      \   'ej': {
      \     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
      \   },
      \   'ef': {
      \     'url': 'http://www.fincd.com/index.php?txtSearch=%s',
      \   },
      \   'fe': {
      \     'url': 'http://www.fincd.com/index.php?txtSearch=%s',
      \   },
      \   'wiki': {
      \     'url': 'http://ja.wikipedia.org/wiki/%s',
      \   },
      \ }

" default site
let g:ref_source_webdict_sites.default = 'ej'

" function for outputs. remove first some lines
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ef.filter(output)
  return join(split(a:output, "\n")[4 :], "\n")
endfunction
function! g:ref_source_webdict_sites.fe.filter(output)
  return join(split(a:output, "\n")[4 :], "\n")
endfunction

" keymap
autocmd filetype ref-webdict nnoremap <buffer> q <c-w>c

" }}}

" changelog{{{
let g:changelog_username = " "
let g:changelog_username = ''
let g:changelog_spacing_errors = 0
"}}}

" open-browser {{{
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
let g:openbrowser_open_rules = { 'w3m': '{browser} {shellescape(uri)} ', }
" }}}

" ambicmd {{{
if isdirectory(expand('$VIMBUNDLE_DIR/vim-ambicmd'))
	cnoremap <expr> <Space> ambicmd#expand("\<Space>")
	cnoremap <expr> <CR>    ambicmd#expand("\<CR>")
<
" Mapping <C-f> to <Right> with ambicmd.
>
	cnoremap <expr> <C-f> ambicmd#expand("\<Right>")
endif
" }}}

" mpc.vim {{{
let g:mpd_host = "localhost"
let g:mpd_port = "6600"
" }}}

" gist.vim {{{
if vimrc.P.is_mac()
  let g:gist_clip_command = 'pbcopy'
elseif vimrc.isos('freebsd')
  let g:gist_clip_command = 'xclip -selection clipboard'
endif

let g:gist_detect_filetype = 1

" show private gists with ':Gist -l'
let g:gist_show_privates = 1
"}}}

" sudo.vim {{{
"let g:sudoAuth="ssh"
"let g:sudoAuthArg="root@localhost"
" }}}

" ctrlp.vim {{{

let g:ctrlp_working_path_mode = 2

" }}}

" syntastic {{{
let g:syntastic_enable_balloons     = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_signs        = 1
let g:syntastic_auto_loc_list       = 2
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': ['ruby', 'javascript', 'sh', 'html', 'css', 'haskell', 'rst'],
      \ 'passive_filetypes': ['puppet'] }
" }}}

" indent-guides {{{
let g:indent_guides_enable_on_vim_startup                   = 0
let g:indent_guides_guide_size                              = 1
let g:indent_guides_start_level                             = 2
let g:indent_guides_space_guides                            = 1
let g:indent_guides_auto_colors                             = 0
autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=233
" }}}

" scheme.vim {{{
" not work on autocmd
let is_gauche=1
" }}}

" slimv {{{
let g:slimv_keybindings = 3
" }}}

" poslist {{{
" nmap <C-o> <Plug>(poslist_prev)
" nmap <C-i> <Plug>(poslist_next)
" }}}

" delimitMate {{{
let delimitMate_matchpairs = "(:),[:],{:},<:>"
let delimitMate_excluded_regions = "Comment,String"

augroup delimitMateSettings
  autocmd FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
  autocmd FileType scheme let b:delimitMate_quotes = "\" ' *"
augroup end
" }}}

" scratch {{{
" open scratch buffer
" if no filename given
if !argc()
  autocmd myautocommands VimEnter * ScratchOpen
endif
" }}}

" paredit {{{
let g:paredit_leader = '\'
let g:paredit_mode = 1
" }}}

" haskell-mode {{{
let g:haddock_browser="/usr/local/bin/firefox"
" }}}

" vinarise {{{
let g:vinarise_enable_auto_detect = 0
" }}}

" kien/rainbow_parentheses {{{
augroup rainbow_parentheses
  autocmd!
  autocmd vimenter * RainbowParenthesesToggle
  autocmd syntax   * RainbowParenthesesLoadRound
  autocmd syntax   * RainbowParenthesesLoadSquare
  autocmd syntax   * RainbowParenthesesLoadBraces
augroup end

let g:rbpt_loadcmd_toggle = 0
let g:rbpt_colorpairs = [
	\ ['brown',       'RoyalBlue3'],
	\ ['Darkblue',    'SeaGreen3'],
	\ ['darkgray',    'DarkOrchid3'],
	\ ['darkgreen',   'firebrick3'],
	\ ['darkcyan',    'RoyalBlue3'],
	\ ['darkred',     'SeaGreen3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['brown',       'firebrick3'],
	\ ['gray',        'RoyalBlue3'],
	\ ['green',       'SeaGreen3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['blue',        'DarkOrchid3'],
	\ ['red',         'firebrick3'],
	\ ]
" (1 (2 (3 (4 (5 (6 (7 (8 (9 (10 (11 (12 (13 (14 (15 (16 (17 (18 (19)))))))))))))))))))
" }

" }}}


" vimclojure {{{
let g:vimclojure#FuzzyIndent = 1
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1
let g:vimclojure#DynamicHighlighting = 1

" }}}

"dwm.vim {{{
let g:dwm_map_keys=0

" map <silent> <C-J> <C-W>w
" map <silent> <C-K> <C-W>W
" map <silent> <C-,> :call DWM_Rotate(0)<CR>
" map <silent> <C-.> :call DWM_Rotate(1)<CR>

map <silent> <localleader>dn :call DWM_New()<CR>
map <silent> <localleader>dc    :call DWM_Close()<CR>
map <silent> <localleader>d<Space> :call DWM_Focus()<CR>
map <silent> <LocalLeader>d@ :call DWM_Focus()<CR>

map <silent> <LocalLeader>dh :call DWM_GrowMaster()<CR>
map <silent> <localleader>dl :call DWM_ShrinkMaster()<CR>
" }}}

"}}}
