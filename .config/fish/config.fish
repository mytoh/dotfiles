# environment {{{

# gentoo prefix
set -x EPREFIX $HOME/local/gentoo

set -Uge PATH#remove PATH
set PATH /usr/local/sbin /usr/local/bin /sbin /bin /usr/sbin /usr/bin /usr/games/

for p in /usr/X11/bin /opt/X11/bin $HOME/local/homebrew/sbin $HOME/local/homebrew/bin $HOME/local/bin $HOME/local/sbin
	if test -d $p
		if not contains $p $PATH
			set -x PATH $p $PATH
		end
	end
end

set -x MANWIDTH 80
set -x GAUCHE_LOAD_PATH "$HOME/.gosh:$HOME/.gosh/share/gauche/site/lib"
set -x DYLD_FALLBACK_LIBRARY_PATH $DYLD_FALLBACK_LIBRARY_PATH "$HOME/local/lib:$HOME/local/homebrew/lib"
if test -d $HOME/local/stow
	set -x STOW $HOME/local/stow
end

# pager
set -x LESS "-i  -w -z-4 -g -M -X -F -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-..."

set -x LESS_TERMCAP_md "[01;31m"
set -x LESS_TERMCAP_me "[0m"
set -x LESS_TERMCAP_se "[0m"
set -x LESS_TERMCAP_so "[01;44;33m"
set -x LESS_TERMCAP_ue "[0m"
set -x LESS_TERMCAP_us "[01;32m"
# set default browser
if which w3m1>  /dev/null
	set -x BROWSER w3m
end
#}}}

# complete {{{
function __gosh_completion
	set -l load_path (echo $GAUCHE_LOAD_PATH | tr ':' '\n')
	for i in $load_path
		for j in $i/*.scm
			echo (basename $j)
		end
	end
end
complete -c gosh -f -a "(__gosh_completion)"
#}}}

# fish variables {{{
set fish_greeting ""
#}}}
set open_paren "[30m([0m"
set close_paren "[30m)[0m"

# prompt {{{
#  arch wiki git status prompt {{{
set fish_git_dirty_color red
function parse_git_dirty
	git diff --quiet HEAD2>&  -
	if test $status = 1
		echo (set_color $fish_git_dirty_color)"÷"(set_color normal)
	end
end

function parse_git_branch
	# git branch outputs lines, the current branch is prefixed with a *
	set -l branch (git branch --color ^&- | awk '/*/ {print $2}')
	echo $branch (parse_git_dirty)
end

function git_prompt
	if test -z (git branch --quiet 2>| awk '/fatal:/ {print "no git"}')
		printf '%s%s%s%s%s' "[30m─" $open_paren (parse_git_branch) (set_color $fish_color_normal) $close_paren
	else
		echo ""
	end
end
#}}}

function current-directory
	printf '%s%s%s%s%s' $open_paren (set_color $fish_color_cwd) (prompt_pwd) (set_color $fish_color_normal) $close_paren
end

function prompt-up-right
	printf '%s%s' "[30m┌─[0m"
end

function prompt-down-right
	printf '%s%s' "[30m└┈╸[0m"
end

function fish_prompt -d "fish prompt function"
	printf '%s%s%s%s\n%s ' (prompt-up-right) (current-directory) (set_color normal) (git_prompt) (prompt-down-right)

end

#}}}

# functions {{{
function xsource
	for i in $argv
		if test -r $i
			. $i
		end
	end
end

function original_cd --description "Change directory"	#{{{

	# Skip history in subshells
	if status --is-command-substitution
		builtin cd $argv
		return $status
	end

	# Avoid set completions
	set -l previous $PWD

	if test $argv[1] = -2>  /dev/null
		if test "$__fish_cd_direction" = next2>  /dev/null
			nextd
		else
			prevd
		end
		return $status
	end

	builtin cd $argv[1]
	set -l cd_status $status

	if test $cd_status = 0 -a "$PWD" != "$previous"
		set -g dirprev $dirprev $previous
		set -e dirnext
		set -g __fish_cd_direction prev
	end

	return $cd_status
end
#}}}

if which gosh1>  /dev/null
	if test -n $GAUCHE_LOAD_PATH
		function cd
			original_cd $argv
			command gosh ls.scm -d .
		end
	else
		function cd
			original_cd $argv
		end
	end
end

function ggr
	# Search Google
	w3m "http://www.google.com/search?&num=100&q=$argv"
end

function 4ch
	w3m "http://boards.4chan.org/$argv[1]/"
end

function recent-file
	command ls -c -t -1 | 	head -n $argv[1] | 	tail -n 1
end

function scm
	switch $argv[1]
		case g gauche gosh
		rlwrap -pBlue -b '(){}[].,#@;| ' gosh
		case sc scsh
		rlwrap -pBlue -b '(){}[],#;| ' scsh
		case s4 scheme48
		rlwrap -pBlue -b '(){}[],#;| ' scheme48
		case e elk
		rlwrap -pBlue -b '(){}[],#;| ' elk
		case '*'
		begin
			echo g gauche
			echo sc scsh
			echo s4 scheme48
			echo e elk
		end
	end
end

# }}}

# aliases {{{

# gauche alias {{{
if which gosh1>&  -
	function yotsuba
		command gosh yotsuba-get.scm $argv
	end
	function futaba
		command gosh futaba-get.scm $argv
	end
	function spc2ubar
		command gosh space2underbar.scm $argv
	end
	function ea
		command gosh extattr.scm $argv
	end
	function unpack
		command gosh unpack.scm $argv
	end
	if test -n $GAUCHE_LOAD_PATH
		function ls
			command gosh ls.scm -d
		end
		function la
			command gosh ls.scm -d -a
		end
		function ll
			command gosh ls.scm -d -psf
		end
		function lla
			command gosh ls.scm -d -psf -a
		end
		function l
			command gosh ls.scm -d
		end
	end
end
#}}}

function pd
	prevd
end
function nd
	nextd
end

if which cdf1>&  -
	function df
		cdf -h
	end
else
	function df
		df -h
	end
end
function single
	sudo shutdown now
end
function halt
	sync
	sync
	sync
	sudo shutdown -p now
end
function reboot
	sync
	sync
	sync
	sudo shutdown -r now
end
function sudo
	sudo -E $argv
end
function xfont
	xlsatoms | 	grep '-'
end
function rr
	command rm -rfv $argv
end
function mkd
	command mkdir -p $argv
end
function stow
	stow --verbose=3 $argv
end
#net {{{
function starwars
	telnet towel.blinkenlights.nl
end
function radio1
	mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r1.asx
end
function radio2
	mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r2.asx
end
function radio3
	mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r3.asx
end
function radio4
	mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r4.asx
end
function radio6
	mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r6.asx
end
function jblive
	mplayer rtsp://videocdn-us.geocdn.scaleengine.net/jblive/jblive.stream
end
function sumo
	mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx
end
function sumo
	mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx
end
function sumo2
	mplayer mms://a776.l12513450775.c125134.a.lm.akamaistream.net/D/776/125134/v0001/reflector:50775
end
function sumo3
	mplayer mms://a792.l12513450791.c125134.a.lm.akamaistream.net/D/792/125134/v0001/reflector:50791
end
#}}}
#}}}

# misc {{{

if xsource ~/local/git/z-fish/z.fish
	function --on-event fish_prompt z-fish
		z --add "$PWD"
	end
end

#}}}

# os {{{
switch (uname)
	case FreeBSD
	# PACKAGESITE="ftp://ftp.jp.FreeBSD.org/pub/FreeBSD/ports/i386/packages/Latest/"
	function pup
		sudo portsnap fetch update
	end
	function pcheck
		sudo portmaster -PBidav
		and sudo portaudit -Fdav
		and sudo portmaster -y --clean-packages --clean-distfiles --check-depends $argv
	end
	function pfetch
		sudo make fetch-recursive
	end
	function pinst
		sudo make install distclean
	end
	function pconf
		sudo make config-recursive
	end
	function pclean
		sudo make clean
	end
	function pkg_add
		pkg_add -v $argv
	end
	function pcreate
		pkg_create -RJvnb
	end
	function pcreateall
		pkg_info -Ea | 		xargs -n 1 sudo pkg_create -Jnvb
	end
	function tm
		tmux -u2 a
	end

	#if test $TERM = "cons25"
	#if test -e (which jfbterm)
	#  jfbterm
	#end
	#end

	function beastie
		echo '
    
    
                [31m,        ,                              
               /(        )`                                   
               \ \___   / |                                   
               /- [37m_[31m  `-/  '\''                      
              ([37m/\/ \[31m \   /\                       
              [37m/ /   |[31m `    \                      
              [34mO O   [37m) [31m/    |                
              [37m`-^--'\''[31m`<     '\''                      
             (_.)  _  )   /                                   
              `.___/`    /                                   
                `-----'\'' /                                     
   [33m<----.[31m     __ / __   \                         
   [33m<----|====[31mO)))[33m==[31m) \) /[33m====]  
   [33m<----'\''[31m    `--'\'' `.__,'\'' \                        
               |        |                                    
                \       /       /\                           
           [36m______[31m( (_  / \______/                
         [36m,'\''  ,-----'\''   |                               
         `--{__________)[37m                                 '

	end

	function orb
		echo '
     [31m```                        [31;1m`[31m    
[31;1m    s` `.....---...[31;1m....--.```   -/[31m         
    +o   .--`         [31;1m/y:`      +.[31m         
     yo`:.            [31;1m:o      `+-[31m          
      y/               [31;1m-/`   -o/[31m           
     .-                  [31;1m::/sy+:.[31m          
[37m     /                     [31;1m`--  /[31m          
[37m    `[31m:                          [31;1m:`[31m         
[37m    `[31m:                          [31;1m:`[31m         
[37m     /                          [31;1m/[31m          
[37m     .[31m-                        [31;1m-.[31m          
      --                      [31;1m-.[31m           
       `:`                  [01;31m`:`                  
         [31;1m.--             [37m`-[33m-.                    
            .---...[33m...----                         '

	end

	case Darwin
	alias mp2 "/Applications/mplayer2.app/Contents/MacOS/mplayer-bin"
	alias bsearch "brew search "
	alias binst "brew install -v"
	function squid_restart
		killall squid
		killall squid
		kill (cat ~/.squid/logs/squid.pid)
		kill (cat ~/.squid/logs/squid.pid)
		/bin/rm -rfv ~/.squid/cache/*
		squid -f ~/.squid/etc/squid.conf -z
		squid -f ~/.squid/etc/squid.conf
	end
	set -x HOMEBREW_VERBOSE
	set -x JAVA_HOME=~/Library/JAVA/JavaVirtualMachines/1.7.0.jdk/Contents/Home
end
#}}}
