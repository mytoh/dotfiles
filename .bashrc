#enable vi mode in shell
#set -o vi

bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'


LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:*.deb=90'
HISTSIZE=100000
HISTFILESIZE=100000

shellar_theme='default'
plugins=(gauche lehti pikkukivi panna)

shellar=~/.shellar

case ${OSTYPE} in
  # FreeBSD) source ~/.bash.d/freebsd.bash ;;
  darwin*) source $shellar/lib/darwin.bash ;;
esac

source $shellar/shellar/shellar.bash
