

# gauche {{{
export GAUCHE_ARCH="$(/usr/local/bin/gauche-config --arch )"
export GAUCHE_LOAD_PATH="$HOME/.gosh/skripti:$HOME/.gosh:$HOME/.gosh/kirjasto:$HOME/local/share/gauche-0.9/site/lib:$HOME/local/lib/gauche-0.9/site/$GAUCHE_ARCH"

# compdef
compdef _gosh gosh
_gosh() {
  _arguments -s : \
    '::scheme files:_files -W $GAUCHE_LOAD_PATH -g "*.scm" ' \
    ':file:_files' \
    && return 0

  _

  return 1
  }

# aliases
if check_com -c gosh; then
  alias spc2ubar='command gosh space2underbar.scm'
  alias ea='command gosh extattr.scm'
  alias tm='gosh tmux-start.scm'
  alias gsp='command gosh -ptime'

  alias pikkukivi='gosh run-pikkukivi.scm'
  alias rr='pikkukivi rm'
  alias nap='pikkukivi napa'
  alias tk='pikkukivi talikko'
  alias pahvi='pikkukivi pahvi'
  alias unpack='pikkukivi unpack'
  alias futaba='pikkukivi futaba'
  alias yotsuba='pikkukivi yotsuba'
  alias gsi='rlwrap gosh pikkukivi.scm repl'
  alias ls='pikkukivi ls -d'
  alias la='pikkukivi ls -d -a'
  alias ll='pikkukivi ls -d -ptsf'
  alias lla='pikkukivi ls -d -ptsf -a'
  alias l='pikkukivi ls -d'
  alias emma='pikkukivi emma'
  alias sgit='pikkukivi sgit'
  alias colour-numbers='pikkukivi colour numbers'
  alias colour-pacman='pikkukivi colour pacman'
  alias colour-spect='pikkukivi colour spect'
  alias topless='pikkukivi topless'
fi

# panna {{{
# add panna to PATH
export OLUTPANIMO="$HOME/.panna"
export PATH=$OLUTPANIMO/bin:$PATH
export GAUCHE_LOAD_PATH=$OLUTPANIMO/kirjasto:$GAUCHE_LOAD_PATH
# }}}

# lehti {{{
export GAUCHE_LOAD_PATH=$HOME/.lehti/share/gauche-0.9/site/lib:$GAUCHE_LOAD_PATH
export GAUCHE_DYNLOAD_PATH=$HOME/.lehti/lib/gauche-0.9/site/$GAUCHE_ARCH
#}}}

#}}}
