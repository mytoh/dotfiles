
if ( { ( which gosh >& /dev/null ) } ) then
# gauche
setenv GAUCHE_ARCH `gauche-config --arch`
setenv GAUCHE_SKRIPTI ${HOME}/.lehti/dist/kirjasto/skripti

alias fi-en 'gosh $GAUCHE_SKRIPTI/skripti/kääntää.scm fi en'
alias en-fi 'gosh $GAUCHE_SKRIPTI/skripti/kääntää.scm en fi'

endif

