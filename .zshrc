# Options
bindkey -e
setopt hist_ignore_dups hist_ignore_all_dups hist_save_no_dups share_history
setopt inc_append_history
setopt auto_cd  auto_pushd extendedglob notify
setopt clobber
setopt list_packed list_types nolist_beep 
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
setopt all_export # may cause problem
unsetopt appendhistory beep nomatch

# Environment
# 
LANG=en_GB.UTF-8
EDITOR=vim
PAGER=less
FTP_PASSIVE_MODE=true
MYVIMRC=~/.vimrc
G_FILENAME_ENCODING=@locale
HOMEBREW_VERBOSE=true
RLWRAP_HOME=~/.rlwrap
LISTMAX=1000
LSCOLORS=ExFxCxdxBxegedabagacad
if [[ -x `which gdircolors` ]]; then
  eval $(gdircolors -b)
fi
ZLS_COLORS=$LS_COLORS
GAUCHE_LOAD_PATH="$HOME/.gosh"

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## zsh directory
path=(~/.cw
      ~/local/bin(N)\
      /usr/games(N)\
      /usr/local/{sbin,bin}\
      /usr/{sbin,bin}\
      /{sbin,bin})
typeset -U path  # remove duplicates
cdpath=(~/local ~/local/var)

fpath=(~/.zsh/functions/completion ${fpath})

# Autoloads
autoload -Uz compinit && compinit
autoload colors &&  colors
#autoload predict-on
#predict-on

# Modules
zmodload zsh/complist


# Zstyles
zstyle :compinstall filename '/Users/kazuki/.zshrc'
zstyle ':completion:*' completer _oldlist _complete
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:(processes|jobs)' menu yes select=2
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'  '+m:[-._]=[-._] r:|[-._]=** r:|=*' '+l:|=*' '+m:{A-Z}={a-z}'
zstyle ':completion:*' format '%BCompleting %b%F{blue}%d'
zstyle ':completion:*' group-name ''


# Prompts
setprompt() {
  case $TERM in
    screen*|jfbterm*)
      PROMPT="%{${fg[blue]}%}┌───(%{${fg[green]}%}%~%{${fg[blue]}%})──(%{${fg[cyan]}%}%n%{${fg[white]}%}@%{${fg[green]}%}%m%{${fg[white]}%}%{${fg[blue]}%})
%{${fg[blue]}%}└──%{${reset_color}%}> "
  PROMPT2="%{${fg[cyan]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[cyan]}%}%r is correct? [n,y,a,e]:%{^[[m%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
  xterm*)
    PROMPT="%{${fg[cyan]}%},----%{${reset_color}%}(%{${fg[green]}%}%~%{${reset_color}%})%{${fg[cyan]}%}(%{${fg[cyan]%}%n%{${fg[white]}%}@%{${fg[green]}%}%m%{${fg[white]}%}%{${fg[cyan]}%})
|--%{${fg[cyan]}%}%{${reset_color}%} > "
;;
  esac


}
setprompt

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

case $TERM in
  screen*)
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
    ;;
  xterm*)
    precmd() {
      print -Pn "\e]0;$TERM - [%n@%M]%# [%~]\a" 
    }
    preexec() {
      print -Pn "\e]0;$TERM - [%n@%M]%# ($l)\a"
    }
    ;;
esac

# Aliases
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
alias -s {tgz,tbz}=gzcat
alias -s {gz,bz2}=tar -xzvf
alias -s {gif,jpg,jpeg,png}=xli
alias -s {m3u,mp3,flac}=audacious
alias -s {mp4,flv,mkv,mpg,mpeg,avi,mov}=mplayer

###
# auto-fu.zsh
{. ~/.zsh/plugins/auto-fu.zsh/auto-fu; auto-fu-install;} 
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=cyan,bold
zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
zstyle ':auto-fu:var' postdisplay ''
zstyle ':auto-fu:var' track-keymap-skip opp
zle-line-init() {auto-fu-init;}; zle -N zle-line-init
zle -N zle-keymap-select auto-fu-zle-keymap-select


source ~/perl5/perlbrew/etc/bashrc
source ~/.zsh/plugins/zaw/zaw.zsh

fortune


