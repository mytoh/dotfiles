
# Options {{{
bindkey -e
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt share_history
setopt auto_cd
setopt auto_pushd
setopt extended_glob
setopt glob_dots
setopt multibyte
setopt notify
setopt auto_name_dirs
setopt clobber
setopt list_packed list_types nolist_beep
setopt hash_list_all
setopt list_rows_first
setopt long_list_jobs
setopt noflow_control
setopt ignore_eof
setopt complete_aliases
setopt magic_equal_subst
setopt auto_remove_slash
setopt no_auto_param_slash
setopt always_last_prompt
setopt prompt_subst
setopt cdable_vars
setopt print_eightbit
setopt transient_rprompt
unsetopt bg_nice appendhistory beep nomatch
limit coredumpsize 0
#umask 022
# }}}

# Environment {{{
# set local variables
local home=$HOME

setopt all_export # may cause problem

LANG=en_GB.UTF-8

EDITOR=vim
MYVIMRC=~/.vimrc
VIMRUNTIME=(~/.vim/vundle:$VIMRUNTIME)

INFOPATH=(~/.emacs.d/info:~/local/share/info:$INFOPATH)
GAUCHE_LOAD_PATH="$home/.gosh"
FTP_PASSIVE_MODE=true
MYGITDIR=~/local/git
G_FILENAME_ENCODING=@locale
RLWRAP_HOME=~/.rlwrap
LISTMAX=0
LSCOLORS=exFxCxdxBxegedabagacad
if [[ -x `which gdircolors` ]] && [[ -e $home/.dir_colors ]]; then
  eval $(gdircolors $home/.dir_colors -b)
fi
ZLS_COLORS=$LS_COLORS

PAGER="less"
LESS='-i  -w -z-4 -g -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
LESS_TERMCAP_mb=$'\E[01;31m'
LESS_TERMCAP_md=$'\E[01;31m'
LESS_TERMCAP_me=$'\E[0m'
LESS_TERMCAP_se=$'\E[0m'
LESS_TERMCAP_so=$'\E[01;44;33m'
LESS_TERMCAP_ue=$'\E[0m'
LESS_TERMCAP_us=$'\E[01;32m'

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

if [ -d /usr/local/lib/cw ]; then
  path=( ~/.cw(N)
         ~/local/*/{sbin,bin}(N)\
         ~/local/bin(N)\
          /opt/X11/bin(N) \
          /usr/X11/bin(N) \
          /usr/X11R6/bin(N) \
          /usr/games(N)\
          /usr/local/{sbin,bin}\
          /usr/local/*/{sbin,bin}(N)\
          /usr/{sbin,bin}\
          /{sbin,bin})
else
  path=( ~/local/*/{sbin,bin}(N)
         ~/local/bin(N)\
          /opt/X11/bin(N) \
          /usr/X11/bin(N) \
          /usr/X11R6/bin(N) \
          /usr/games(N)\
          /usr/local/{sbin,bin}\
          /usr/local/*/{sbin,bin}(N)\
          /usr/{sbin,bin}\
          /{sbin,bin})
fi


typeset -U path  # remove duplicates
cdpath=(~/local ~/local/var)
## zsh functions directory
fpath=(~/.zsh/functions/completion ${fpath})
# }}}

# named directories {{{
# $ cd ~dir
hash -d quatre=~/local/mnt/quatre
hash -d deskstar=~/local/mnt/deskstar
hash -d mypassport=~/local/mnt/mypassport
# }}}

# Autoloads {{{
autoload -Uz compinit  && compinit -C # ignore insecure directories in $fpath
autoload colors &&  colors
autoload -Uz zmv
autoload -Uz is-at-least
# }}}

# Modules {{{
zmodload zsh/complist
# }}}

# compdef {{{
compdef _portmaster portbuilder 
# }}}

# Zstyles {{{
zstyle :compinstall filename $home/.zshrc
zstyle ':completion:*' completer _oldlist _complete
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:(processes|jobs)' menu yes select=2
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'  '+m:[-._]=[-._] r:|[-._]=** r:|=*' '+l:|=*' '+m:{A-Z}={a-z}'
zstyle ':completion:*' format 'Completing %F{blue}%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache true
zstyle ':completion:*:functions' ignore-patterns '_*'
# }}}

# git prompt {{{
##if is-at-least 4.3.10; then
##  autoload -Uz vcs_info
##  autoload -Uz add-zsh-hook
##
##  zstyle ':vcs_info:*' enable git
##  zstyle ':vcs_info:git:*' check-for-changes true
##  zstyle ':vcs_info:git:*' stagedstr '+'
##  zstyle ':vcs_info:git:*' unstagedstr "${fg[yellow]}-"
##  zstyle ':vcs_info:git:*' formats '(@%b%u%c)'
##  zstyle ':vcs_info:git:*' actionformats '@%b|%a%u%c'
##
##  function _update_vcs_info_msg() {
##    psvar=()
##    LANG=en_US.UTF-8 vcs_info
##    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
##    psvar[2]=$(_git_not_pushed)
##  }
##  function _git_not_pushed() {
##  if [ "$(git rev-parse --is-inside-word-tree 2>/dev/null)" = "true" ]; then
##    head="$(git rev-parse HEAD)"
##    for x in $(git rev-parse --remotes)
##    do
##      if [ "$head" = "$x" ]; then
##        return 0
##      fi
##    done
##    echo "?"
##  fi
##  return 0
##  }
##  add-zsh-hook precmd _update_vcs_info_msg
##fi
### }}
#
# }}}

# git prompt from {{{
# briancarper.net/tag/249/zsh 
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' stagedstr '%F{28}● '
zstyle ':vcs_info:*' unstagedstr '%F{11}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn

_update_vcs_info_msg() {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{blue}]'
  } else {
    zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}+%F{blue}]'
  }
  vcs_info
}

add-zsh-hook precmd _update_vcs_info_msg
# }}}

# Prompts {{{
# muridana
PROMPT="%{$fg[green]%}[%~]%{$fg[white]%} "
# git prompt
PROMPT+='%F{blue}${vcs_info_msg_0_}%F{blue} %(?/%F{blue}/%F{red})%{$reset_color%}'
####
PROMPT+="%{$reset_color%}"
PROMPT+=$'\n'
PROMPT+="%{$fg[cyan]%}>>>%{$fg[white]%} "
PROMPT2="%{$fg[cyan]%}%_%%%{$reset_color%} "
SPROMPT="%{$fg[cyan]%}%r is correct? [n,y,a,e]:%{^[[m%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{$fg[red]%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') $PROMPT"
if [[ $TERM != cons25 ]]; then
RPROMPT="%{$fg[cyan]%}(・×・) "
fi
# }}}

# History search keymap {{{
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "\\en" history-beginning-search-forward-end
# }}}

# Functions {{{

# zshwiki hardstatus
_title() {
  if [[ $TERM == screen* ]]; then
    print -nR $'\033k'$1$'\033'\\
    print -nR $'\033]0;'$2$'\a'
  elif [[ $TERM == xterm* || $TERM == jfbterm* ]]; then
    print -nR $'\033]0;'$*$'\a'
  fi
}

precmd() {
  _title zsh "$PWD"
  rehash
}

preexec() {
  emulate -L zsh
  local -a cmd; cmd=(${(z)1})
  _title $cmd[1]:t "$cmd[2,-1]"
}
# }}}


# alias functions {{{
tm() {
  if tmux ls >/dev/null 2>&1; then
    tmux attach
  else
    tmux -u2
  fi
}

svim() {
  if [[ -n `pgrep X` ]]; then
    vim --servername VIM --remote-silent $1
  else
    vim $1
  fi
}

# archive function
# http://www.christoph-polcin.com/blog/zsh-archive-funcition
pack() {
  if [[ $# -lt 2 ]];
  then
    echo "compress files and directories via:"
    echo " pack archive_file file [dir|file]*"
    return 1
  fi

  [[ -f $1 ]] && echo "error: destination archive_file exists" && return 1

  local lower
  lower=${(L)1}
  case $lower in
    *.tar.xz|*.xz)
      tar cvf $@;;
    *)
      echo "'$1' cannot be created via 'pack'";;
  esac
}

unpack() {
  local lower
  lower=${(L)1}
  case $lower in
    *.tar.xz|*.tar.bz2|*.tar.gz)
      tar xvf $@;;
    *.txz|*.tbz2|*.tgz)
      tar xvf $@;;
    *.zip)
      unzip $@;;
  esac
}
# }}}

# Aliases {{{
#alias precmd=rehash
alias pd=popd
alias cup="cpan-outdated && cpan-outdated | xargs cpanm -v"
alias view="vim -X -R -"
alias scsh="rlwrap scsh"
alias goshrl="rlwrap -pBlue -b '(){}[],#;| ' gosh"
alias ew="emacs -f w3m"
alias single="sudo shutdown now"
alias halt="sync;sync;sync;sudo shutdown -p now"
alias reboot="sync;sync;sync;sudo shutdown -r now"
alias sudo="sudo -E "
alias zln="noglob zmv -L -s -W"
alias zmv='noglob zmv -W'
alias cp='cp -iv'
alias mv='mv -iv'
alias df='df -h'
alias starwars='telnet towel.blinkenlights.nl'
# suffix aliases
alias -s txt=cat
alias -s zip=zipinfo
alias -s {tgz,tbz}=gzcat
alias -s {gz,bz2}=tar -xzvf
alias -s {gif,jpg,jpeg,png}=xli
alias -s {m3u,mp3,flac}=audacious
alias -s {mp4,flv,mkv,mpg,mpeg,avi,mov}=mplayer
# }}}

# misc {{{

if [ -e $home/perl5 ]; then
source ~/perl5/perlbrew/etc/bashrc
fi

if [ -e $home/.zsh/plugins/zaw/zaw.zsh ]; then
source ~/.zsh/plugins/zaw/zaw.zsh
fi

#[[ -s $home/.rvm/scripts/rvm ]] && source $home/.rvm/scripts/rvm

if [[ $TERM = cons25 && -e /usr/local/bin/jfbterm ]]; then
  jfbterm
fi

if [ -x /usr/games/fortune ]; then
  if [ -f /usr/local/share/games/fortune/bible ]; then
    fortune /usr/local/share/games/fortune/bible
  else
    fortune
  fi
  echo "\n"
fi
# }}}

# Os detection {{{
case ${OSTYPE} in
  beos*|haiku*)
  path=( ~/config/bin \
    /boot/common/bin \
    /boot/apps \
    /boot/preferences \
    /boot/system/apps \
    /boot/system/preferences \
    /boot/develop/tools/gnupro/bin \
    ${path})
  alias la="ls -a"
  alias reboot="shutdown -r"
  alias halt="shutdown"
  chpwd() {
    ls -F
  }
  TERMINFO=/boot/common/share/terminfo
  ;;
  solaris*)
  alias la="ls  -a"
  alias ll="ls  -hlA "
  alias ls="ls  -F"
  chpwd() {
    ls -F
  }
  ;;
  darwin*)
  HOMEBREW_VERBOSE=true
  alias la="ls -G -a"
  alias ll="ls -G -hlA "
  alias ls="ls -G -F"
  chpwd() {
    ls -G -F
  }
  squid_restart() {
    killall squid
    killall squid
    kill `cat ~/.squid/logs/squid.pid`
    kill `cat ~/.squid/logs/squid.pid`
    /bin/rm -rfv ~/.squid/cache/*
    squid -f ~/.squid/etc/squid.conf -z
    squid -f ~/.squid/etc/squid.conf
    export JAVA_HOME=~/Library/JAVA/JavaVirtualMachines/1.7.0.jdk/Contents/Home
  }
  ;;
  freebsd*)
  http_proxy="http://192.168.1.3:3128"
  ftp_proxy=""
  alias la="ls -G -a"
  alias ll="ls -G -hlA "
  alias ls="ls -G -F"
  alias pup="sudo portsnap fetch update "
  alias pcheck="sudo portmaster -PBida && sudo portaudit -Fdav && sudo portmaster -y --clean-packages --clean-distfiles --check-depends"
  alias pfetch="sudo make  fetch-recursive"
  alias pinst="sudo make  install distclean; rehash"
  alias pconf="sudo make config-recursive"
  alias pclean="sudo make  clean "
  alias pkg_add="pkg_add -v"
  chpwd() {
    ls -G -F
  }
  beastie() {
    echo '
                \e[31m,        ,                              
               /(        )`                                   
               \ \___   / |                                   
               /- \e[37m_\e[31m  `-/  '\''                       
              (\e[37m/\/ \\\e[31m \   /\                       
              \e[37m/ /   |\e[31m `    \                      
              \e[34mO O   \e[37m) \e[31m/    |                
              \e[37m`-^--'\''\e[31m`<     '\''                      
             (_.)  _  )   /                                   
              `.___/`    /                                   
                `-----'\'' /                                     
   \e[33m<----.\e[31m     __ / __   \                         
   \e[33m<----|====\e[31mO)))\e[33m==\e[31m) \) /\e[33m====]  
   \e[33m<----'\''\e[31m    `--'\'' `.__,'\'' \                        
               |        |                                    
                \       /       /\                           
           \e[36m______\e[31m( (_  / \______/                
         \e[36m,'\''  ,-----'\''   |                               
         `--{__________)\e[37m                                 '



}

orb() {
  echo '
     \e[31m```                        \e[31;1m`\e[31m    
\e[31;1m    s` `.....---...\e[31;1m....--.```   -/\e[31m         
    +o   .--`         \e[31;1m/y:`      +.\e[31m         
     yo`:.            \e[31;1m:o      `+-\e[31m          
      y/               \e[31;1m-/`   -o/\e[31m           
     .-                  \e[31;1m::/sy+:.\e[31m          
\e[37m     /                     \e[31;1m`--  /\e[31m          
\e[37m    `\e[31m:                          \e[31;1m:`\e[31m         
\e[37m    `\e[31m:                          \e[31;1m:`\e[31m         
\e[37m     /                          \e[31;1m/\e[31m          
\e[37m     .\e[31m-                        \e[31;1m-.\e[31m          
      --                      \e[31;1m-.\e[31m           
       `:`                  \e[01;31m`:`                  
         \e[31;1m.--             \e[37m`-\e[33m-.                    
            .---...\e[33m...----                         '
}


;;
esac
#}}}

# vim: set foldmethod=marker:
