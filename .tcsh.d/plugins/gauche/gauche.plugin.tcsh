
# gauche
setenv GAUCHE_ARCH `gauche-config --arch`
setenv GAUCHE_KIRJASTO ${HOME}/.kirjasto
setenv GAUCHE_KIRJASTO_LIB ${GAUCHE_KIRJASTO}/src
setenv GAUCHE_LOAD_PATH ${GAUCHE_KIRJASTO_LIB}

alias fi-en 'gosh $GAUCHE_KIRJASTO/skripti/kääntää.scm fi en'
alias en-fi 'gosh $GAUCHE_KIRJASTO/skripti/kääntää.scm en fi'



