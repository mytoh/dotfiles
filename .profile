set -o notify
set -o noclobber
set -o ignoreeof

shopt -s histverify
shopt -s extglob
shopt -s cdable_vars

shopt -u mailwarn
unset MAILCHECK

export HISTCONTROL=ignoreboth
export HISTSIZE=10000

red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
darkgray='\e[1;30m'
green='\e[32m'
NC='\e[0m'

PS1="${green}[\w] ${cyan}(\s) \n${blue}>>> ${NC}"

# functions
unpack()
{
   if [ -f $1 ]; then
	case $1 in
	     *.tar.bz2|*.tar.gz) 
	       tar xvf $1 ;;
             *.zip)
	       unzip $1;;
	esac
   else
	echo "'$1' is not a valid file"
   fi
}

if [ $OSTYPE = "Haiku" ]; then
  cd()
  {
    cd "$*"
    ls --group-directories-first --color
  }
fi

share_history()
{
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend


alias halt='shutdown'
alias reboot='shutdown -r'
alias la='ls --group-directories-first -A'
alias ll='ls --group-directories-first -lgA'
alias ls='ls --group-directories-first --color'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ..='cd ..'
alias ...='cd ../../'


bind "\C-p":history-search-backward
bind "\C-n":history-search-forward
bind "\C-u":kill-whole-line

complete -A hostname sftp ssh
complete -A directory mkdir rmdir
complete -A directory -o default cd


