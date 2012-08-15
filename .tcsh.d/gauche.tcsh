
# gauche 
setenv GAUCHE_ARCH `gauche-config --arch`
setenv GAUCHE_LOAD_PATH "$HOME/.gosh/skripti:$HOME/.gosh:$HOME/.gosh/kirjasto:$HOME/local/share/gauche-0.9/site/lib:$HOME/local/lib/gauche-0.9/site/$GAUCHE_ARCH"


# panna {{{
# add panna to PATH
  setenv OLUTPANIMO  "$HOME/.panna"
    set path=($OLUTPANIMO/bin $path)
    setenv GAUCHE_LOAD_PATH $OLUTPANIMO/kirjasto:$GAUCHE_LOAD_PATH
#}}}


if ( { which gosh >& /dev/null } ) then
    alias spc2ubar 'command gosh space2underbar.scm'
    alias ea 'command gosh extattr.scm'
    alias tm 'gosh tmux-start.scm'
    alias gsp 'command gosh -ptime'

    alias pikkukivi 'gosh run-pikkukivi.scm'
    alias rr 'pikkukivi rm'
    alias nap 'pikkukivi napa'
    alias tk 'pikkukivi talikko'
    alias pahvi 'pikkukivi pahvi'
    alias unpack 'pikkukivi unpack'
    alias futaba 'pikkukivi futaba'
    alias yotsuba 'pikkukivi yotsuba'
    alias gsi 'rlwrap gosh run-pikkukivi.scm repl'
    alias ls 'pikkukivi ls -d'
    alias la 'pikkukivi ls -d -a'
    alias ll 'pikkukivi ls -d -ptsf'
    alias lla 'pikkukivi ls -d -ptsf -a'
    alias l 'pikkukivi ls -d'
    alias emma 'pikkukivi emma'
    alias sgit 'pikkukivi ääliö'
    alias colour-numbers 'pikkukivi colour numbers'
    alias colour-pacman 'pikkukivi colour pacman'
    alias colour-spect 'pikkukivi colour spect'
    alias colour-square 'pikkukivi colour square'
    alias topless 'pikkukivi topless'
    alias radio 'pikkukivi radio listen'
    alias radio-list 'pikkukivi radio list'
    endif
