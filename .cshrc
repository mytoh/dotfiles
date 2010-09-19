
set promptchars=">,#"
set prompt="%c2 %# "
set history=100000
set savehist=(100000 merge)
set autolist = ambiguous
set ignoreeof
set histdup=erase
set rmstar
set inputmode=insert
set color
set colorcat
set autoexpand
set complete=enhance
set path = (~/local/bin ~/local/sbin /usr/local/bin /sbin /bin /usr/sbin /usr/bin /usr/local/sbin )
set noclobber
set notify
set time=(8 "\
    Time spent in user mode   (CPU seconds) : %Us\
    Time spent in kernel mode (CPU seconds) : %Ss\
    Total time                              : %Es\
    CPU utilisation (percentage)            : %P\
    Times the process was swapped           : %W\
    Times of major page faults              : %F\
    Times of major page faults              : %R")

limit coredumpsize 0
setenv TERM xterm-256color
setenv LANG en_US.UTF-8
setenv EDITOR vim
setenv PAGER less
setenv FTP_PASSIVE_MODE true
setenv MYVIMRC ~/.vimrc
setenv NLSPATH ~/local/lib/tcsh/%N
set catalog=ja.ayanami.cat

bindkey -v
bindkey "" backward-delete-word
bindkey "" history-search-backward
bindkey "" history-search-forward


alias cwdcmd ls-F
alias quit 'sync;sync;sync;sudo shutdown -p now'
alias res 'sync;sync;sync;sudo reboot'
#alias pup 'sudo portsnap fetch update && sudo portmaster -Bdfav --clean-packages --clean-distfiles && sudo portaudit -av'
alias pup 'sudo portsnap fetch update && sudo pkg_replace -Bcav && sudo portaudit -av && rehash'
alias cup 'cpan-outdated && cpan-outdated | xargs cpanm -Sv'
alias sc screen -U -D -RR  -s /bin/tcsh -m 
alias la gls -a --color=auto
alias lf gls -FA --color=auto
alias ll gls -lA --color=auto
alias find gfind
alias pinst "sudo make  install clean distclean && rehash"
alias pconf sudo make config-recursive
alias pclean sudo make clean distclean
alias awk gawk
alias vi  vim

complete cd 'p/1/d/'
complete make 'p/1/(all clean distclean depend  install install.man Makefiles buildworld installworld config-recursive)/'
complete sudo 'p/1/(make vim portsnap)/'
complete tar      'n/{,-}[crtux]*z*f/f:*.{tar.gz,tar.Z,tgz,TGZ}/' \
                  'n/{,-}[crtux]*f/f:*.tar/'  \
                          'n/*/f/'
                          
source ~/perl5/perlbrew/etc/cshrc 


alias base64 gbase64
alias basename gbasename
alias cat gcat
alias chcon gchcon
alias chgrp gchgrp
alias chmod gchmod
alias chown gchown
alias chroot gchroot
alias cksum gcksum
alias comm gcomm
alias cp gcp -iv
alias csplit gcsplit
alias cut gcut
alias date gdate
alias dd gdd
alias df gdf
alias dir gdir
alias dircolors gdircolors
alias dirname gdirname
alias du gdu -k
alias echo gecho
alias env genv
alias expand gexpand
alias expr gexpr
alias factor gfactor
alias false gfalse
alias fmt gfmt
alias fold gfold
alias groups ggroups
alias head ghead
alias hostid ghostid
alias id gid
alias install ginstall
alias join gjoin
alias kill gkill
alias link glink
alias ln gln
alias logname glogname
alias ls gls --color=auto
alias md5sum gmd5sum
alias mkdir gmkdir
alias mkfifo gmkfifo
alias mknod gmknod
alias mktemp gmktemp
alias mv gmv -iv
alias nice gnice
alias nl gnl
alias nohup gnohup
alias nproc gnproc
alias od god
alias paste gpaste
alias pathchk gpathchk
alias pinky gpinky
alias pr gpr
alias printenv gprintenv
alias printf gprintf
alias ptx gptx
alias pwd gpwd
alias readlink greadlink
alias rm grm 
alias rmdir grmdir
alias roups groups
alias runcon gruncon
alias seq gseq
alias sha1sum gsha1sum
alias sha224sum gsha224sum
alias sha256sum gsha256sum
alias sha384sum gsha384sum
alias sha512sum gsha512sum
alias shred gshred
alias shuf gshuf
alias sleep gsleep
alias sort gsort
alias split gsplit
alias stat gstat
alias stty gstty
alias sum gsum
alias sync gsync
alias tac gtac
alias tail gtail
alias tee gtee
alias test gtest
alias timeout gtimeout
alias touch gtouch
alias tr gtr
alias true gtrue
alias truncate gtruncate
alias tsort gtsort
alias tty gtty
alias uname guname
alias unexpand gunexpand
alias uniq guniq
alias unlink gunlink
alias uptime guptime
alias users gusers
alias vdir gvdir
alias wc gwc
alias who gwho
alias whoami gwhoami
alias yes gyes
