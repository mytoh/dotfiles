#enable vi mode in shell
#set -o vi


LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:*.deb=90'
HISTSIZE=100000
HISTFILESIZE=100000

bash_theme='default'
plugins=(gauche lehti pikkukivi panna)


case ${OSTYPE} in
  # FreeBSD) source ~/.bash.d/freebsd.bash ;;
  darwin*) source ~/.bash.d/mac.bash ;;
esac

source ~/.bash.d/oh-my-bash.bash
