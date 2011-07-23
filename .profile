umask 022

set -o notify
set -o noclobber
set -o ignoreeof
set -o vi

shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s cmdhist
shopt -s histverify
shopt -s extglob
shopt -s dotglob
shopt -s nocaseglob

shopt -u mailwarn
unset MAILCHECK


HISTCONTROL=erasedups:ignoredups:ignorespace
HISTIGNORE='&:bg:fg:ll:h'
HISTSIZE=99999
HISTFILESIZE=2000
export CDPATH=".:~:~/local"
export LESS='-i -N -w -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

if [ "$OSTYPE" = "beos" ]; then
export TERM=xterm
export TERMINFO=/boot/common/share/terminfo
fi

# {{{ functions
unpack()
{
   if [ -f $1 ]; then
  case $1 in
       *.tar.bz2|*.tar.gz|*.tar.xz)
         tar xvf $1 ;;
             *.zip)
         unzip $1;;
  esac
   else
  echo "'$1' is not a valid file"
   fi
}

if [ "$OSTYPE" = "beos" ]; then
  cd ()
  {
    if [ $# == '0' ]; then
        builtin cd
	ls -F
    else
        builtin cd "$*"
        ls -F
    fi
  }
fi
# }}}

# {{{ prompt commands
# { git
# http://d.hatena.ne.jp/snaka72/20090129/1233238778
# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
parse_git_dirty()
{
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch
{
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[$(parse_git_dirty)]/"
  #git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
# }

prompt_command()
{
  PS1="${lightgreen}[\w] ${lightcyan}(\s) ${yellow}X/_/X ${lightred}$(parse_git_branch)\n${blue} >>> ${nc}"
    hash -r
}

PROMPT_COMMAND='prompt_command'

black='\e[0;30m' # Black - Regular
red='\e[0;31m' # Red
green='\e[0;32m' # Green
yellow='\e[0;33m' # Yellow
blue='\e[0;34m' # Blue
purple='\e[0;35m' # Purple
cyan='\e[0;36m' # Cyan
White='\e[0;37m' # White
lightblack='\e[1;30m' # Black - Bold
lightred='\e[1;31m' # Red
lightgreen='\e[1;32m' # Green
lightyellow='\e[1;33m' # Yellow
lightblue='\e[1;34m' # Blue
lightpurpl='\e[1;35m' # Purple
lightcyan='\e[1;36m' # Cyan
lightwhite='\e[1;37m' # White
nc='\e[0m'

# }}}

alias halt='shutdown'
alias reboot='shutdown -r'
alias la='ls --group-directories-first -A'
alias ll='ls --group-directories-first -lhgA'
alias ls='ls --group-directories-first --color'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias du='du -kh'
alias df='df -kTh'
alias ..='cd ..'
alias ...='cd ../../'


bind '"\C-p":history-search-backward'
bind '"\C-n":history-search-forward'
bind '"\C-u":kill-whole-line'
#stty werase undef
bind '"\C-w":backward-kill-word'

complete -A hostname sftp ssh
complete -A directory mkdir rmdir
complete -A directory -o default cd
# compressios
complete -f -o default -X '*.+(zip|ZIP)' zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '!*.+(zip|gz|bz2|xz)' unpack


if [ ! -d "${HOME}/local/bin" ]; then
    mkdir ${HOME}/local/bin
    chmod 700 ${HOME}/local/bin
    echo "${HOME}/local/bin was missing.  I created it for you."
fi

