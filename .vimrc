"
"          __
"  __  __ /\_\    ___ ___   _ __   ___
" /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\
" \ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/
"  \ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
"   \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
"
"

" NeoBundle and bundles configuration {{{
if filereadable(expand('~/.vim/config/bundle.vim'))
source $HOME/.vim/config/bundle.vim
endif
"}}}

filetype plugin indent on " required
syntax enable

 " if isdirectory(expand('~/.vim/config'))
 "   source ~/.vim/config/global.vim
 "   source ~/.vim/config/plugins.vim
 "   source ~/.vim/config/tabpage.vim
 " endif

 runtime! config/*.vim

set secure
" hg clone https://vim.googlecode.com/hg/ vim
" cd vim/src
" ./configure --prefix=/home/mytoh/local --enable-multibyte --enable-perlinterp=yes --with-x --enable-xim --disable-darwin --disable-selinux --enable-fontset
" make install clean distclean

"" umlaut characters
" ^v228 ^vu00e4 ä
" ^v246 ö
" ^v235 ë

"" ansicolor
" vim2ansi.vim
" :Toansi 
" :AnsiEsc

" vim:set foldmethod=marker:
