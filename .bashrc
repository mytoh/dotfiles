#enable vi mode in shell
#set -o vi

bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'


LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:*.deb=90'
HISTSIZE=100000
HISTFILESIZE=100000

sheller_theme='default'
plugins=(gauche lehti pikkukivi panna)

sheller=~/.sheller

case ${OSTYPE} in
  # FreeBSD) source ~/.bash.d/freebsd.bash ;;
  darwin*) source $sheller/lib/mac.bash ;;
esac

source $sheller/sheller/sheller.bash
