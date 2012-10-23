
if ( { ( which gosh >& /dev/null ) } ) then
# gauche
setenv GAUCHE_ARCH `gauche-config --arch`
setenv GAUCHE_LOAD_PATH ""
setenv GAUCHE_SKRIPTI ${HOME}/.lehti/dist/kirjasto/skripti

alias fi-en 'gosh $GAUCHE_SKRIPTI/kääntää.scm fi en'
alias en-fi 'gosh $GAUCHE_SKRIPTI/kääntää.scm en fi'

endif

