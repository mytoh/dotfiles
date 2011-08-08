" First run
" $ cd .vim/ && mkdir bundle
" $ cd bundle && git submodule git://github.com/gmarik/vundle
" $ vim -u $HOME/.vim-bundles +BundleInstall +q

"turn filetype off not to load ftdetect
set nocompatible
filetype off     " required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle {{{
Bundle 'gmarik/vundle'
"}}}

" my bundles here {{{
"
" github repo
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/vinarise'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'godlygeek/tabular'
Bundle 'hakobe/unite-script'
Bundle 'kana/vim-fakeclip'
Bundle 'koron/chalice'
Bundle 'lilydjwg/colorizer'
Bundle 'mattn/googlereader-vim'
Bundle 'mattn/unite-remotefile'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/wwwrenderer-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-afterimage'
Bundle 'tyru/eskk.vim'
Bundle 'tyru/savemap.vim'
Bundle 'tyru/vice.vim'
Bundle 'ujihisa/neco-look'
Bundle 'ujihisa/unite-colorscheme'
Bundle 'ujihisa/vimshell-ssh'

" vim-scripts repo
"Bundle 'gauref.vim'
Bundle 'info.vim'
Bundle 'eregex.vim'
Bundle 'sudo.vim'
Bundle 'jellybeans.vim'
Bundle 'YankRing.vim'
" other git repo

" }}}

" vim:set foldmethod=marker:
