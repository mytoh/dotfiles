
# environment {{{

ulimit -c 0

set -ge PATH
set -gx PATH  /usr/local/{sbin,bin} /{sbin,bin} /usr/{sbin,bin} /usr/games/ $PATH

set -x CURRENT_SHELL fish

push-to-path $HOME/.config/fish/bin

# gentoo prefix {{{
set -x EPREFIX $HOME/local/gentoo
push-to-path $EPREFIX/tmp/bin $EPREFIX/tmp/usr/bin $EPREFIX/bin $EPREFIX/usr/bin
# }}}

push-to-path /usr/local/kde4/bin $HOME/local/homebrew/{sbin,bin} $HOME/local/{sbin,bin}

# haskell package {{{
push-to-path $HOME/.cabal/bin
# }}}

# disable home directory completion
set CDPATH .

set -x MANWIDTH 80
if test -d $HOME/local/stow
  set -x STOW $HOME/local/stow
end
set -x LANG       fi_FI.UTF-8
set -x LC_ALL     fi_FI.UTF-8
set -x LC_CTYPE   fi_FI.UTF-8
set -x MM_CHARSET fi_FI.UTF-8

# pager
set -x LESS "-i  -w -z-4 -g -M -X -F -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-..."

set -x LESS_TERMCAP_md "[01;31m"
set -x LESS_TERMCAP_me "[0m"
set -x LESS_TERMCAP_se "[0m"
set -x LESS_TERMCAP_so "[01;44;33m"
set -x LESS_TERMCAP_ue "[0m"
set -x LESS_TERMCAP_us "[01;32m"

# set default browser
if which w3m 1>  /dev/null
  set -x BROWSER w3m
end

# editor
if which vim 1> /dev/null
set -x EDITOR vim
end

set -x GREP_OPTIONS "--colour=auto"

# java
set -x _JAVA_OPTIONS -Dawt.useSystemAAFontSettings=on

# rlwrap
set -x RLWRAP_HOME ~/.rlwrap

set -x IGNOREEOF 1

#}}}
