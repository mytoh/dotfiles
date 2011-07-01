set -o notify
set -o noclobber
set -o ignoreeof

shopt -s histappend histverify
shopt -s extglob
shopt -u mailwarn
unset MAILCHECK

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
function unpack() 
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


alias reboot="shutdown -r"

complete -A hostname sftp ssh
complete -A directory mkdir rmdir
complete -A directory -o default cd


