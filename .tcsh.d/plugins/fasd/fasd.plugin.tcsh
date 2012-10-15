

if ( { ( which fasd >& /dev/null ) } ) then
eval `fasd --init tcsh-alias tcsh-hook`

alias v 'f -t -e vim -b viminfo'
alias m 'f -e mplayer'
alias o 'f -e xdg-open'

endif
