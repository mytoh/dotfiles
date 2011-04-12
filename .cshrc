
set term=xterm-256color
set promptchars=">,#"
#set prompt='%{[0000mk\\%}[%{[34m%n[37m@[32m%m[m%}] %c2 > '
set prompt='%{[0000mk\\%}[%{[34m%n[37m@[32m%m[m%}] %c2 > '
set history=100000
set savehist=(100000 merge)
set autolist = ambiguous
set ignoreeof
set histdup=erase
set rmstar
set inputmode=insert
set listlinks
set listjobs=long
set ellipsis
set implicitcd=verbose
set color
set colorcat
set autoexpand
set complete=enhance
set path = (~/.cw /usr/local/lib/cw ~/local/bin ~/local/sbin /usr/local/bin /sbin /bin /usr/sbin /usr/bin /usr/local/sbin )
set cdpath = (~/local/ ~/local/var/)
set noclobber
set notify
set padhour
set time=(8 "\
    Time spent in user mode   (CPU seconds) : %Us\
    Time spent in kernel mode (CPU seconds) : %Ss\
    Total time                              : %Es\
    CPU utilisation (percentage)            : %P\
    Times the process was swapped           : %W\
    Times of major page faults              : %F\
    Times of major page faults              : %R")

#umask 022
limit coredumpsize 0
setenv LANG en_GB.UTF-8
#setenv LC_ALL ja_JP.UTF-8
setenv EDITOR vim
setenv PAGER less
setenv FTP_PASSIVE_MODE true
setenv MYVIMRC ~/.vimrc
setenv G_FILENAME_ENCODING @locale
setenv SCSH_LIB_DIRS ' "." "/usr/home/mytoh/.scsh" "/usr/local/lib/scsh/" "/usr/local/lib/scsh/0.6" "#f"'
setenv YPSILON_SITELIB ~/.ypsilon
setenv YPSILON_LOADPATH ~/.ypsilon
set catalog=ja.ayanami.cat
setenv NLSPATH ~/local/lib/tcsh/%N

bindkey -e
bindkey "" backward-delete-word
bindkey "" history-search-backward
bindkey "" history-search-forward

stty kill 
stty stop undef # disable C-s key

alias cwdcmd ls-F 
#alias jobcmd 'echo -n "]2\;\!#"'
alias precmd rehash
alias pup 'sudo portsnap fetch update '
alias pcheck 'sudo portmaster -PBidav && sudo portaudit -Fdav && sudo portmaster --clean-packages --clean-distfiles'
#alias pup 'sudo portsnap fetch update && sudo pkg_replace -Bcav && sudo portaudit -av && rehash'
alias cup 'cpan-outdated && cpan-outdated | xargs cpanm -Sv'
alias sc screen -U -D -RR  -s /bin/tcsh -m 
alias la ls-F -a
alias ll ls-F -hlA 
alias ls ls-F
alias pfetch 'sudo make  fetch-recursive'
alias pinst "sudo make  install distclean; rehash"
alias pconf sudo make  config-recursive
alias pclean 'sudo make  clean '
alias view "vim -X -R -"
alias vim "vim -X"
alias .. 'cd ..'
alias scsh 'rlwrap scsh'
alias goshrl 'rlwrap gosh'
alias ew 'emacs -f w3m'
alias single 'sudo shutdown now'
alias halt 'sync;sync;sync;sudo shutdown -p now'
alias reboot 'sync;sync;sync;sudo shutdown -r now'
alias sudo 'sudo -E '


source $HOME/.complete.tcsh


