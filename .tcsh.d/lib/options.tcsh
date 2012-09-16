
set history=100000
set savehist=(100000 merge)
set autolist = ambiguous
set autocorrect
set ignoreeof
set filec
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
set path = (~/local/app/* ~/local/bin ~/local/homebrew/bin /usr/local/kde4/{sbin,bin} /usr/local/{sbin,bin} /{sbin,bin} /usr/{sbin,bin} )
set cdpath = (~/local/ ~/local/var/)
set noclobber
set notify
set padhour
# set time=(8 "\
#     Time spent in user mode   (CPU seconds) : %Us\
#     Time spent in kernel mode (CPU seconds) : %Ss\
#     Total time                              : %Es\
#     CPU utilisation (percentage)            : %P\
#     Times the process was swapped           : %W\
#     Times of major page faults              : %F\
#     Times of major page faults              : %R")

#umask 022
limit coredumpsize 0

stty kill 
stty stop undef # disable C-s key
