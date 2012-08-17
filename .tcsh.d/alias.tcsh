
alias cwdcmd ls-F 
#alias jobcmd 'echo -n "]2\;\!#"'
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
alias cp 'cp -rLpv'
alias mv 'mv -iv'
alias rr 'command rm -rfv'
alias mkd 'mkdir -pv'
which dfc >& /dev/null
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

