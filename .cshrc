
set term=xterm
set promptchars=">,#"
set prompt="[%{\e[34m%n\e[37m@\e[32m%m\e[m%}] %c2 %# "
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
set cdpath = (~/local/ ~/local/var/)
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
set catalog=ja.ayanami.cat
setenv NLSPATH ~/local/lib/tcsh/%N

bindkey -v
bindkey "" backward-delete-word
bindkey "" history-search-backward
bindkey "" history-search-forward

stty kill 

alias cwdcmd ls-F 
#alias jobcmd 'echo -n "]2\;\!#"'
alias precmd rehash
alias quit 'sync;sync;sync;sudo shutdown -p now'
alias res 'sync;sync;sync;sudo shutdown -r now'
alias pup 'sudo portsnap fetch update '
alias pcheck 'sudo portmaster -PBidav && sudo portaudit -Fdav && sudo portmaster --clean-packages --clean-distfiles'
#alias pup 'sudo portsnap fetch update && sudo pkg_replace -Bcav && sudo portaudit -av && rehash'
alias cup 'cpan-outdated && cpan-outdated | xargs cpanm -Sv'
alias sc screen -U -D -RR  -s /bin/tcsh -m 
alias la ls-F -a
alias ll ls-F -hlA 
alias vi vim
alias find gfind
alias pfetch 'sudo make fetch-recursive'
alias pinst "sudo make install distclean; rehash"
alias pconf sudo make config-recursive
alias pclean sudo make clean distclean
alias awk gawk
alias view "vim -R -"
alias .. 'cd ..'
alias scsh 'rlwrap scsh'
alias gosh 'rlwrap gosh'
alias ew 'emacs -f w3m'

complete cd 'p/1/d/'
complete make 'p/1/(all clean distclean depend  install install.man Makefiles buildworld installworld config-recursive)/'
complete sudo 'p/1/(make vim portsnap)/'
complete tar      'n/{,-}[crtux]*z*f/f:*.{tar.gz,tar.Z,tgz,TGZ}/' \
                  'n/{,-}[crtux]*f/f:*.tar/'  \
                          'n/*/f/'
complete {pkg_*,port*} 'n...@*@D:/var/db/pkg@ @'

if ( -e $home/perl5/perlbrew/etc/cshrc ) then
  source $home/perl5/perlbrew/etc/cshrc 
endif

if ( $SHLVL == 1 && $term != "xterm" ) then
  set term=jfbterm && jfbterm
endif

source $HOME/.complete.tcsh


