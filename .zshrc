# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups share_history
setopt autocd  auto_pushd extendedglob notify
setopt list_packed nolist_beep
setopt noautoremoveslash
setopt complete_aliases
unsetopt appendhistory beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/kazuki/.zshrc'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit
autoload colors
colors
autoload predict-on
predict-on

# End of lines added by compinstall

# Environment
export LANG=ja_JP.UTF-8
export PATH="$HOME/local/bin:$HOME/local/homebrew/bin:$HOME/local/homebrew/sbin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
export EDITOR=vim
export PAGER=less
export FTP_PASSIVE_MODE=true
export MYVIMRC=~/.vimrc
export G_FILENAME_ENCODING=@locale
export HOMEBREW_VERBOSE
export RLWRAP_HOME=~/.rlwrap
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:;bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Prompts
PROMPT="%{${fg[blue]}%}%/%%%{${reset_color}%} "
PROMPT="%{${fg[blue]}%}%_%%%{${reset_color}%} "
SPROMPT="%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{^[[m%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"

# History search keymap
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end 
bindkey "\\ep" history-beginning-search-backward-end 
bindkey "^N" history-beginning-search-forward-end
bindkey "\\en" history-beginning-search-forward-end

precmd() {
  rehash
}

# Aliases
#alias precmd=rehash

alias pup="sudo portsnap fetch update "
alias pcheck="sudo portmaster -PBidav && sudo portaudit -Fdav && sudo portmaster --clean-packages --clean-distfiles"
alias cup="cpan-outdated && cpan-outdated | xargs cpanm -Sv"
alias sc="screen -U -D -RR -m "
alias la="ls -G -a"
alias ll="ls -G -hlA "
alias ls="ls -G"
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

