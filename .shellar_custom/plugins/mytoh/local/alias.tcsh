
## aliases
alias cwdcmd ls-F
#alias jobcmd 'echo -n "]2\;\!#"'
#alias sc screen -U -D -RR  -s /bin/tcsh -m
# alias tm 'if (tumx ls >/dev/null 2>&1) then \\
#               tumx attach                   \\
#             else                            \\
#               tmux -u2                      \\
#           endif'
alias mv 'mv -iv'


alias .. 'cd ..'
alias scsh 'rlwrap scsh'
alias single 'sudo shutdown now'
alias halt 'sync;sync;sync;sudo shutdown -p now'
alias reboot 'sync;sync;sync;sudo shutdown -r now'
alias take 'mkdir -p \!:1; chdir \!:1'



if (-X dfc) then
    alias df 'dfc'
    else if (-X cdf) then
        alias df 'cdf -h'
    else
        alias df 'df -h'
endif
