

# pikkukivi {{{
# add pikkukivi to PATH
set -x PIKKUKIVI "$HOME/.pikkukivi"
set -x GAUCHE_LOAD_PATH $PIKKUKIVI/lib:$GAUCHE_LOAD_PATH
push-to-path $PIKKUKIVI/bin

. $PIKKUKIVI/aliases.sh
# }}}

