
## aliases
alias cwdcmd ls-F
#alias postcmd 'echo -n "]2;\!#:q"'
alias mv 'mv -iv'
alias .. 'cd ..'
alias single 'sudo shutdown now'
alias halt 'sync;sync;sync;sudo shutdown -p now'
alias take 'mkdir -p \!:1 && chdir \!:1'
alias pam 'rm -rf'
alias globalip 'fetch -q -o - http://ifconfig.me/ip'
alias clip-fetch 'xclip -o | xargs fetch'
alias clip-base 'xclip -o | xargs basename'
alias clip-mkdir 'clip-base | xargs mkdir -v -p'
alias clip-mpv ' mpv "`clip`" '
alias clip 'xclip -o'
alias k 'killall -9'

if (-X dfc) then
    alias df 'dfc'
    else if (-X cdf) then
        alias df 'cdf -h'
    else
        alias df 'df -h'
endif

if (-X aria2c) then
    alias get aria2c
else
    alias get fetch
endif
