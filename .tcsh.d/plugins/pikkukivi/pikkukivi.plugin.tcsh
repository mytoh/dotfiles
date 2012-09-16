


# pikkukivi {{{
# add pikkukivi to PATH
setenv PIKKUKIVI "$HOME/.pikkukivi"
setenv GAUCHE_LOAD_PATH $PIKKUKIVI/lib:$GAUCHE_LOAD_PATH
set path=($PIKKUKIVI/bin $path)

source $PIKKUKIVI/misc/aliases.csh
# }}}

