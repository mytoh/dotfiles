
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


runtime! config/global.vim
runtime! config/autocmd.vim
runtime! config/commands.vim
runtime! config/keymap.vim
runtime! config/options.vim
runtime! config/plugins.vim
runtime! config/tabpage.vim
