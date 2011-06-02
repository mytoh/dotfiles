# Options
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
setopt cdable_vars
setopt print_eightbit
setopt transient_rprompt
unsetopt bg_nice appendhistory beep nomatch
limit coredumpsize 0
umask 002

##
# Environment
setopt all_export # may cause problem
LANG=fi_FI.UTF-8
EDITOR=vim
PAGER=less
FTP_PASSIVE_MODE=true
MYVIMRC=~/.vimrc
G_FILENAME_ENCODING=@locale
HOMEBREW_VERBOSE=true
RLWRAP_HOME=~/.rlwrap
LISTMAX=0
LSCOLORS=exFxCxdxBxegedabagacad
if [[ -x `which gdircolors` ]] && [[ -e $HOME/.dir_colors ]]; then
  eval $(gdircolors $HOME/.dir_colors -b)
fi
ZLS_COLORS=$LS_COLORS
GAUCHE_LOAD_PATH="$HOME/.gosh"

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## zsh directory
path=(~/.cw(N)
      ~/local/homebrew/{sbin,bin}(N)\
       ~/local/bin(N)\
       /usr/games(N)\
       /usr/local/{sbin,bin}\
       /usr/{sbin,bin}\
       /{sbin,bin})
typeset -U path  # remove duplicates
cdpath=(~/local ~/local/var)
fpath=(~/.zsh/functions/completion ${fpath})

##
# named directories
# $ cd ~dir
hash -d quatre=~/local/mnt/quatre
hash -d deskstar=~/local/mnt/deskstar
hash -d mypassport=~/local/mnt/mypassport

# Autoloads
autoload -Uz compinit && compinit
autoload colors &&  colors
autoload -Uz zmv

# Modules
zmodload zsh/complist


# Zstyles
zstyle :compinstall filename '/Users/kazuki/.zshrc'
zstyle ':completion:*' completer _oldlist _complete
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:(processes|jobs)' menu yes select=2
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'  '+m:[-._]=[-._] r:|[-._]=** r:|=*' '+l:|=*' '+m:{A-Z}={a-z}'
zstyle ':completion:*' format 'Completing %F{blue}%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:functions' ignore-patterns '_*'

# compdef
compdef _portmaster portbuilder 

# Prompts
PROMPT="%{$fg[green]%}%~%{$fg[white]%} > "
PROMPT2="%{$fg[cyan]%}%_%%%{$reset_color%} "
SPROMPT="%{$fg[cyan]%}%r is correct? [n,y,a,e]:%{^[[m%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{$fg[red]%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') $PROMPT"

# History search keymap
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "\\en" history-beginning-search-forward-end

## Functions
chpwd() {
  ls -G -F
}

# zshwiki hardstatus
title() {
  if [[ $TERM == screen* ]]; then
    print -nR $'\033k'$1$'\033'\\
    print -nR $'\033]0;'$2$'\a'
  elif [[ $TERM == xterm* || $TERM == jfbterm* ]]; then
    print -nR $'\033]0;'$*$'\a'
  fi
}

precmd() {
  title zsh "$PWD"
  rehash
}

preexec() {
  emulate -L zsh
  local -a cmd; cmd=(${(z)1})
  title $cmd[1]:t "$cmd[2,-1]"
}

tm() {
  if tmux ls >/dev/null 2>&1; then
    tmux attach
  else
    tmux
  fi
}

# Aliases
#alias precmd=rehash
alias pup="sudo portsnap fetch update "
alias pcheck="sudo portmaster -PBidav && sudo portaudit -Fdav && sudo portmaster --clean-packages --clean-distfiles"
alias cup="cpan-outdated && cpan-outdated | xargs cpanm -Sv"
alias la="ls -G -a"
alias ll="ls -G -hlA " 
alias ls="ls -G -F"
alias pfetch="sudo make  fetch-recursive"
alias pinst="sudo make  install distclean; rehash"
alias pconf="sudo make  config-recursive"
alias pclean="sudo make  clean "
alias view="vim -X -R -"
alias scsh="rlwrap scsh"
alias goshrl="rlwrap -pBlue -b '(){}[],#;| ' gosh"
alias ew="emacs -f w3m"
alias single="sudo shutdown now"
alias halt="sync;sync;sync;sudo shutdown -p now"
alias reboot="sync;sync;sync;sudo shutdown -r now"
alias sudo="sudo -E "
alias zln="zmv -L"
# suffix aliases
alias -s txt=cat
alias -s zip=zipinfo
alias -s {tgz,tbz}=gzcat
alias -s {gz,bz2}=tar -xzvf
alias -s {gif,jpg,jpeg,png}=xli
alias -s {m3u,mp3,flac}=audacious
alias -s {mp4,flv,mkv,mpg,mpeg,avi,mov}=mplayer

###
# auto-fu.zsh
{. ~/.zsh/plugins/auto-fu.zsh/auto-fu; auto-fu-install;} 
#zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=cyan,bold
zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
zstyle ':auto-fu:var' postdisplay ''
zstyle ':auto-fu:var' track-keymap-skip opp
zle-line-init() {auto-fu-init;}; zle -N zle-line-init
zle -N zle-keymap-select auto-fu-zle-keymap-select

if [ -e $HOME/perl5 ]; then
source ~/perl5/perlbrew/etc/bashrc
fi

source ~/.zsh/plugins/zaw/zaw.zsh

#[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

if [ $TERM = cons25 ]; then
  jfbterm
fi

fortune


