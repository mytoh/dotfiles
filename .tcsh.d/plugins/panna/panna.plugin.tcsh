
# panna {{{
# add panna to PATH
  setenv OLUTPANIMO  "$HOME/.panna"
    set path=($OLUTPANIMO/bin $path)
    setenv GAUCHE_LOAD_PATH $OLUTPANIMO/kirjasto:$GAUCHE_LOAD_PATH
#}}}

