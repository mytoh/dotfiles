
" vim-jsbeautify
let s:rootDir = fnamemodify(expand("<sfile>"), ":h")
let g:jsbeautify_file = fnameescape(s:rootDir."/bundle/js-beautify/beautify.js")
let g:htmlbeautify_file = fnameescape(s:rootDir."/bundle/js-beautify/beautify-html.js")
let g:cssbeautify_file = fnameescape(s:rootDir."/bundle/js-beautify/beautify-css.js")
