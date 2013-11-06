## options
set nobeep
set history=100000
set savehist=(100000 merge)
set autolist=ambiguous
unset autocorrect
set addsuffix
# set ignoreeof
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
set complete=Enhance
set path=(~/.cabal/bin ~/.local/bin ~/local/ohjelmat/{v2c} ~/local/bin /usr/local/kde4/{sbin,bin} /usr/local/{sbin,bin} /{sbin,bin} /usr/{sbin,bin} $path)
set cdpath=(~/local/)
set noclobber
set notify
set autorehash
set highlight
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

if ($?prompt) then
stty kill 
stty stop undef # disable C-s key
endif
