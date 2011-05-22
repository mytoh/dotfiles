# Environment
export TERM=xterm-256color
export LANG=en_GB.UTF-8
export EDITOR=vim
export PAGER=less
export FTP_PASSIVE_MODE=true
export MYVIMRC=~/.vimrc
export G_FILENAME_ENCODING=@locale
export HOMEBREW_VERBOSE
export RLWRAP_HOME=~/.rlwrap
export LISTMAX=1000
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:;bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

## zsh directory
path=(~/local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:${path})
fpath=(~/.zsh/functions/completion ${fpath})

# Autoloads
autoload -Uz compinit; compinit
autoload colors; colors
#autoload predict-on
#predict-on

# Modules
zmodload zsh/complist


# Options
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
bindkey -e
bindkey '^i' expand-or-complete-prefix
setopt hist_ignore_dups hist_ignore_all_dups hist_save_no_dups share_history
setopt auto_cd  auto_pushd extendedglob notify
#setopt auto_menu
setopt clobber
setopt list_packed list_types nolist_beep 
setopt auto_param_slash noauto_remove_slash
setopt noflow_control
setopt ignore_eof
setopt complete_aliases
setopt magic_equal_subst
setopt print_eightbit
setopt transient_rprompt
unsetopt appendhistory beep nomatch

# Zstyles
zstyle :compinstall filename '/Users/kazuki/.zshrc'
zstyle ':completion:*' completer _match _complete _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:functions' ignore-patterns '_*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} m:[-._]=[-._] r:|[-._]=** r:|=*' '+l:|=*'


# Prompts
PROMPT="%{${fg[cyan]}%}%~%{${reset_color}%} > "
PROMPT2="%{${fg[cyan]}%}%_%%%{${reset_color}%} "
SPROMPT="%{${fg[cyan]}%}%r is correct? [n,y,a,e]:%{^[[m%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
# right prompt
RPROMPT="[%{$fg[cyan]%}%n%{${fg[white]}%}@%{${fg[green]}%}%m%{${fg[white]}%}]"

# History search keymap
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end 
bindkey "\\ep" history-beginning-search-backward-end 
bindkey "^N" history-beginning-search-forward-end
bindkey "\\en" history-beginning-search-forward-end

# Functions
chpwd() {
  ls -G -F
}

# setting for screen
# from zshwiki
# 
title() {
  print -nR $'\033k'$1$'\033'\\
  print -nR $'\033]0;'$2$'\a'
}

precmd() {
  title zsh "$PWD"
  rehash
}

preexec() {
  emulate -L zsh
  local -a cmd; cmd=(${(z)1})
  title $cmd[1]:t "$cmd[2,-1]"
#  printf "\ek$1\e\\"
}


## Aliases
#alias precmd=rehash
alias pup="sudo portsnap fetch update "
alias pcheck="sudo portmaster -PBidav && sudo portaudit -Fdav && sudo portmaster --clean-packages --clean-distfiles"
alias cup="cpan-outdated && cpan-outdated | xargs cpanm -Sv"
alias sc="screen -U -D -RR -m "
alias la="ls -G -a"
alias ll="ls -G -hlA " alias ls="ls -G"
alias pfetch="sudo make  fetch-recursive"
alias pinst="sudo make  install distclean; rehash"
alias pconf="sudo make  config-recursive"
alias pclean="sudo make  clean "
alias view="vim -X -R -"
alias vim="vim -X"
alias scsh="rlwrap scsh"
alias goshrl="rlwrap -pBlue -b '(){}[],#;| ' gosh"
alias ew="emacs -f w3m"
alias single="sudo shutdown now"
alias halt="sync;sync;sync;sudo shutdown -p now"
alias reboot="sync;sync;sync;sudo shutdown -r now"
alias sudo="sudo -E "
# aliases for files
alias -s txt=cat
alias -s zip=zipinfo
alias -s tgz=gzcat
alias -s tbz=bzcat
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s gif=xli
alias -s jpg=xli
alias -s jpeg=xli
alias -s png=xli
alias -s m3u=audacious
alias -s mp4=mplayer
alias -s flv=mplayer
alias -s mkv=mplayer


source /usr/home/mytoh/perl5/perlbrew/etc/bashrc

fortune


