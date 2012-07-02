
# Colors!
set     red="%{\033[1;31m%}"
set   green="%{\033[0;32m%}"
set  yellow="%{\033[1;33m%}"
set    blue="%{\033[1;34m%}"
set magenta="%{\033[1;35m%}"
set    cyan="%{\033[1;36m%}"
set   white="%{\033[0;37m%}"
set     end="%{\033[0m%}" # This is needed at the end... :(

set promptchars=">,#"
#set prompt='%{[0000mk\\%}[%{[34m%n[37m@[32m%m[m%}] %c2 > '
set prompt="%{[0000mk\\%}[%{${blue}%n${white}@${green}%m] ${white}(${blue}%c2) \n>>> ${end}"
set history=100000
set savehist=(100000 merge)
set autolist = ambiguous
set autocorrect
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
set path = ( ~/local/bin /usr/local/{sbin,bin} /{sbin,bin} /usr/{sbin,bin} )
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
setenv RLWRAP_HOME ~/.rlwrap

bindkey -e
bindkey '' backward-delete-word
bindkey '' history-search-backward
bindkey '' history-search-forward

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
# alias tm 'if (tumx ls >/dev/null 2>&1) then \\ 
#               tumx attach                   \\ 
#             else                            \\ 
#               tmux -u2                      \\ 
#           endif'                               
alias la ls-F -a
alias ll ls-F -hlA 
alias ls ls-F
alias cp 'cp -rLpv'
alias mv 'mv -iv'
alias rr 'command rm -rfv'
alias mkd 'mkdir -pv'
which dfc
if ($? == 0) then
alias df 'dfc'
else
alias df 'df -h'
endif
alias pfetch 'sudo make  fetch-recursive'
alias pinst "sudo make  install distclean; rehash"
alias pconf sudo make  config-recursive
alias pclean 'sudo make  clean '
alias view "vim -X -R -"
alias vim "vim -X"
alias .. 'cd ..'
alias scsh 'rlwrap scsh'
alias goshrl "rlwrap -pBlue -b '(){}[],#;| ' gosh"
alias ew 'emacs -f w3m'
alias single 'sudo shutdown now'
alias halt 'sync;sync;sync;sudo shutdown -p now'
alias reboot 'sync;sync;sync;sudo shutdown -r now'
alias sudo 'sudo -E '

# gauche 
setenv    GAUCHE_ARCH `gauche-config --arch`
setenv GAUCHE_LOAD_PATH "$HOME/.gosh:$HOME/.gosh/skripti:$HOME/local/share/gauche-0.9/site/lib:$HOME/local/lib/gauche-0.9/site/$GAUCHE_ARCH"
alias tm gosh tmux-start.scm
alias nap gosh napa.scm
# panna {{{
# add panna to PATH
setenv OLUTPANIMO  "$HOME/.panna"
set path=($OLUTPANIMO/bin $path)
setenv GAUCHE_LOAD_PATH $OLUTPANIMO/kirjasto:$GAUCHE_LOAD_PATH

# }}}



















foreach f ($HOME/.complete.tcsh $HOME/perl5/perlbrew/etc/cshrc)
  if (-f $f) then
    source $f
    endif
end

