" First run
" $ cd .vim/ && mkdir bundle
" $ cd bundle && git submodule git://github.com/gmarik/vundle
" $ vim -u $HOME/.vim-bundles +BundleInstall +q

"turn filetype off not to load ftdetect
set nocompatible
filetype off     " required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" {{ my bundles here
"
" github repo
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vinarise'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
"Bundle 'koron/chalice'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kana/vim-fakeclip'
Bundle 'tyru/vice.vim'
Bundle 'tyru/savemap.vim'
Bundle 'tyru/eskk.vim'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'lilydjwg/colorizer'
Bundle 'hakobe/unite-script'
Bundle 'mattn/unite-remotefile'
Bundle 'mattn/googlereader-vim'
Bundle 'ujihisa/unite-colorscheme'
Bundle 'ujihisa/neco-look'
Bundle 'ujihisa/vimshell-ssh'
Bundle 'koron/chalice'
" vim-scripts repo
"Bundle 'gauref.vim'
Bundle 'info.vim'
Bundle 'eregex.vim'
Bundle 'sudo.vim'
" other git repo
"
" }}
