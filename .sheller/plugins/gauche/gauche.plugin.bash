


# gauche {{{
export GAUCHE_ARCH="$(gauche-config --arch )"
export GAUCHE_LOAD_PATH="$HOME/.gosh/skripti:$HOME/.gosh:$HOME/.gosh/kirjasto:$HOME/local/share/gauche-0.9/site/lib:$HOME/local/lib/gauche-0.9/site/$GAUCHE_ARCH"

# compdef
_gosh() {
  _arguments -s : \
    '::scheme files:_files -W $GAUCHE_LOAD_PATH -g "*.scm" ' \
    ':file:_files' \
    && return 0

  _

  return 1
  }


#}}}
