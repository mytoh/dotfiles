ulimit -c 0
# environment {{{

# gentoo prefix
set -x EPREFIX $HOME/local/gentoo

set -Uge PATH #remove PATH
set PATH /usr/local/{sbin,bin} /{sbin,bin} /usr/{sbin,bin} /usr/games/

for p in /usr/local/kde4/bin /usr/X11/bin /opt/X11/bin $HOME/local/homebrew/{sbin,bin} $HOME/local/{sbin,bin}
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
set -x LANG fi_FI.UTF-8

# pager
set -x LESS "-i  -w -z-4 -g -M -X -F -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-..."

set -x LESS_TERMCAP_md "[01;31m"
set -x LESS_TERMCAP_me "[0m"
set -x LESS_TERMCAP_se "[0m"
set -x LESS_TERMCAP_so "[01;44;33m"
set -x LESS_TERMCAP_ue "[0m"
set -x LESS_TERMCAP_us "[01;32m"
# set default browser
if which w3m 1>  /dev/null
  set -x BROWSER w3m
end
#}}}

set -x GREP_OPTIONS "--colour=auto"

# complete {{{
#if test -d ~/.config/fish/completions
#  for p in ~/.config/fish/completions/*
#    if test -d $p
#      set fish_complete_path $p/completions $fish_complete_path
#    end
#  end
#end

# gauche {{{
function __gosh_completion_load_path
  set -l load_path (echo $GAUCHE_LOAD_PATH | tr ':' '\n')
  for i in $load_path
    for j in $i/*.scm
      echo (basename $j)
    end
  end
end

function __gosh_completion_current_directory
  command ls *.scm
end

complete -c gosh -f -a "(__gosh_completion_load_path)" -d "files in GAUCHE_LOAD_PATH"
complete -c gosh -f -a "(__gosh_completion_current_directory)" -d "files in CWD"
#}}}
#}}}

# fish variables {{{
set fish_greeting ""
# colors {{{
# black, red, green, brown, yellow, blue, magenta, purple, cyan, white, normal
set fish_color_normal normal
set fish_color_command cyan
set fish_color_comment -o white
set fish_color_cwd blue
set fish_color_end cyan
set fish_color_error red
set fish_color_match magenta
set fish_color_param magenta
set fish_color_redirection yellow
set fish_color_search_match brown
set fish_color_substitution green
set fish_color_operator cyan
set fish_color_escape purple
set fish_color_quote purple
set fish_color_valid_path brown
#}}}
#}}}
set open_paren "[30m([0m"
set close_paren "[30m)[0m"

# prompt {{{
#  arch wiki git status prompt {{{
set fish_git_dirty_color red
function parse_git_dirty
  git diff --quiet HEAD 2>&-
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

function prompt_pwd_mod -d 'prompt_pwd modification for /usr/home/${USER} on FreeBSD'
  switch "$PWD"
  case "/usr$HOME"
    echo '~'
  case "/usr$HOME/*"
    printf "%s" (echo $PWD|sed -e "s|^/usr$HOME|~|" -e 's-/\(\.\{0,1\}[^/]\)\([^/]*\)-/\1-g')
    echo $PWD | sed -n -e 's-.*/\.\{0,1\}.\([^/]*\)-\1-p'
  case '*'
    prompt_pwd
  end
end

function current-directory
  printf '%s%s%s%s%s' $open_paren (set_color $fish_color_cwd) (prompt_pwd_mod) (set_color $fish_color_normal) $close_paren
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

if which gosh 1>  /dev/null
  if test -n $GAUCHE_LOAD_PATH
    function cd
      if test -d $argv[1]
        builtin cd $argv
        and command gosh ls.scm -d .
      else
        builtin cd (dirname $argv[1])
        and command gosh ls.scm -d .
      end
    end
  else
    function cd
      builtin cd $argv
    end
  end
end

function ggr
  # Search Google
  w3m "http://www.google.co.jp/search?&num=100&q=$argv"
end

function 4ch
  w3m "http://boards.4chan.org/$argv[1]/"
end

function recent-file
  command ls -c -t -1 |   head -n $argv[1] |  tail -n 1
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

# color functions {{{
# functions from
# http://crunchbanglinux.org/forums/post/126921/#p126921

function colors-pacman #{{{
 set blackf  "[30m"; set redf    "[31m"; set greenf  "[32m"
 set yellowf "[33m"; set bluef   "[34m"; set purplef "[35m"
 set cyanf   "[36m"; set whitef  "[37m"

 set blackb  "[40m"; set redb    "[41m"; set greenb  "[42m"
 set yellowb "[43m"; set blueb   "[44m"; set purpleb "[45m"
 set cyanb   "[46m"; set whiteb  "[47m"

 set boldon "[1m"; set boldoff "[22m"
 set italicson "[3m"; set italicsoff "[23m"
 set ulon "[4m";     set uloff "[24m"
 set invon "[7m";   set invoff "[27m"

 set reset "[0m"

 echo "
 $yellowf  ▄███████▄$reset   $redf  ▄██████▄$reset    $greenf  ▄██████▄$reset    $bluef  ▄██████▄$reset    $purplef  ▄██████▄$reset    $cyanf  ▄██████▄$reset
 $yellowf▄█████████▀▀$reset  $redf▄$whitef█▀█$redf██$whitef█▀█$redf██▄$reset  $greenf▄$whitef█▀█$greenf██$whitef█▀█$greenf██▄$reset  $bluef▄$whitef█▀█$bluef██$whitef█▀█$bluef██▄$reset  $purplef▄$whitef█▀█$purplef██$whitef█▀█$purplef██▄$reset  $cyanf▄$whitef█▀█$cyanf██$whitef█▀█$cyanf██▄$reset
 $yellowf███████▀$reset      $redf█$whitef▄▄█$redf██$whitef▄▄█$redf███$reset  $greenf█$whitef▄▄█$greenf██$whitef▄▄█$greenf███$reset  $bluef█$whitef▄▄█$bluef██$whitef▄▄█$bluef███$reset  $purplef█$whitef▄▄█$purplef██$whitef▄▄█$purplef███$reset  $cyanf█$whitef▄▄█$cyanf██$whitef▄▄█$cyanf███$reset
 $yellowf███████▄$reset      $redf████████████$reset  $greenf████████████$reset  $bluef████████████$reset  $purplef████████████$reset  $cyanf████████████$reset
 $yellowf▀█████████▄▄$reset  $redf██▀██▀▀██▀██$reset  $greenf██▀██▀▀██▀██$reset  $bluef██▀██▀▀██▀██$reset  $purplef██▀██▀▀██▀██$reset  $cyanf██▀██▀▀██▀██$reset
 $yellowf  ▀███████▀$reset   $redf▀   ▀  ▀   ▀$reset  $greenf▀   ▀  ▀   ▀$reset  $bluef▀   ▀  ▀   ▀$reset  $purplef▀   ▀  ▀   ▀$reset  $cyanf▀   ▀  ▀   ▀$reset

 $boldon$yellowf  ▄███████▄   $redf  ▄██████▄    $greenf  ▄██████▄    $bluef  ▄██████▄    $purplef  ▄██████▄    $cyanf  ▄██████▄$reset
 $boldon$yellowf▄█████████▀▀  $redf▄$whitef█▀█$redf██$whitef█▀█$redf██▄  $greenf▄$whitef█▀█$greenf██$whitef█▀█$greenf██▄  $bluef▄$whitef█▀█$bluef██$whitef█▀█$bluef██▄  $purplef▄$whitef█▀█$purplef██$whitef█▀█$purplef██▄  $cyanf▄$whitef█▀█$cyanf██$whitef█▀█$cyanf██▄$reset
 $boldon$yellowf███████▀      $redf█$whitef▄▄█$redf██$whitef▄▄█$redf███  $greenf█$whitef▄▄█$greenf██$whitef▄▄█$greenf███  $bluef█$whitef▄▄█$bluef██$whitef▄▄█$bluef███  $purplef█$whitef▄▄█$purplef██$whitef▄▄█$purplef███  $cyanf█$whitef▄▄█$cyanf██$whitef▄▄█$cyanf███$reset
 $boldon$yellowf███████▄      $redf████████████  $greenf████████████  $bluef████████████  $purplef████████████  $cyanf████████████$reset
 $boldon$yellowf▀█████████▄▄  $redf██▀██▀▀██▀██  $greenf██▀██▀▀██▀██  $bluef██▀██▀▀██▀██  $purplef██▀██▀▀██▀██  $cyanf██▀██▀▀██▀██$reset
 $boldon$yellowf  ▀███████▀   $redf▀   ▀  ▀   ▀  $greenf▀   ▀  ▀   ▀  $bluef▀   ▀  ▀   ▀  $purplef▀   ▀  ▀   ▀  $cyanf▀   ▀  ▀   ▀$reset
 "

end
# }}}

function colors-invader #{{{
 set blackf  "[30m"; set redf    "[31m"; set greenf  "[32m"
 set yellowf "[33m"; set bluef   "[34m"; set purplef "[35m"
 set cyanf   "[36m"; set whitef  "[37m"

 set blackb  "[40m"; set redb    "[41m"; set greenb  "[42m"
 set yellowb "[43m"; set blueb   "[44m"; set purpleb "[45m"
 set cyanb   "[46m"; set whiteb  "[47m"

 set boldon "[1m"; set boldoff "[22m"
 set italicson "[3m"; set italicsoff "[23m"
 set ulon "[4m";     set uloff "[24m"
 set invon "[7m";   set invoff "[27m"

 set reset "[0m"

 echo "

   $boldon$redf▀▄   ▄▀  $reset    $boldon$greenf▄▄▄████▄▄▄ $reset   $boldon$yellowf  ▄██▄  $reset     $boldon$bluef▀▄   ▄▀  $reset    $boldon$purplef▄▄▄████▄▄▄ $reset   $boldon$cyanf  ▄██▄  $reset
  $boldon$redf▄█▀███▀█▄ $reset   $boldon$greenf███▀▀██▀▀███$reset   $boldon$yellowf▄█▀██▀█▄$reset    $boldon$bluef▄█▀███▀█▄ $reset   $boldon$purplef███▀▀██▀▀███$reset   $boldon$cyanf▄█▀██▀█▄$reset
 $boldon$redf█▀███████▀█$reset   $boldon$greenf▀▀▀██▀▀██▀▀▀$reset   $boldon$yellowf▀▀█▀▀█▀▀$reset   $boldon$bluef█▀███████▀█$reset   $boldon$purplef▀▀▀██▀▀██▀▀▀$reset   $boldon$cyanf▀▀█▀▀█▀▀$reset
 $boldon$redf▀ ▀▄▄ ▄▄▀ ▀$reset   $boldon$greenf▄▄▀▀ ▀▀ ▀▀▄▄$reset   $boldon$yellowf▄▀▄▀▀▄▀▄$reset   $boldon$bluef▀ ▀▄▄ ▄▄▀ ▀$reset   $boldon$purplef▄▄▀▀ ▀▀ ▀▀▄▄$reset   $boldon$cyanf▄▀▄▀▀▄▀▄$reset

   $redf▀▄   ▄▀  $reset    $greenf▄▄▄████▄▄▄ $reset   $yellowf  ▄██▄  $reset     $bluef▀▄   ▄▀  $reset    $purplef▄▄▄████▄▄▄ $reset   $cyanf  ▄██▄  $reset
  $redf▄█▀███▀█▄ $reset   $greenf███▀▀██▀▀███$reset   $yellowf▄█▀██▀█▄$reset    $bluef▄█▀███▀█▄ $reset   $purplef███▀▀██▀▀███$reset   $cyanf▄█▀██▀█▄$reset
 $redf█▀███████▀█$reset   $greenf▀▀▀██▀▀██▀▀▀$reset   $yellowf▀▀█▀▀█▀▀$reset   $bluef█▀███████▀█$reset   $purplef▀▀▀██▀▀██▀▀▀$reset   $cyanf▀▀█▀▀█▀▀$reset
 $redf▀ ▀▄▄ ▄▄▀ ▀$reset   $greenf▄▄▀▀ ▀▀ ▀▀▄▄$reset   $yellowf▄▀▄▀▀▄▀▄$reset   $bluef▀ ▀▄▄ ▄▄▀ ▀$reset   $purplef▄▄▀▀ ▀▀ ▀▀▄▄$reset   $cyanf▄▀▄▀▀▄▀▄$reset


                                     $whitef▌$reset

                                   $whitef▌$reset
                                   $whitef$reset
                                  $whitef▄█▄$reset
                              $whitef▄█████████▄$reset
                              $whitef▀▀▀▀▀▀▀▀▀▀▀$reset

"


end
#}}}

function colors-dump  #{{{
  set xdef $HOME/.xcolours/(grep "xcolours" $HOME/.Xresources | sed -re '/^!/d; /^$/d; s/^#include//; s/.*\/([a-z]+)\"$/\1/g;')
  set colors (sed -re '/^!/d; /^$/d; /^#/d; s/(\*color)([0-9]):/\10\2:/g;' $xdef | grep 'color[01][0-9]:' | sort |sed 's/^.*: *//g' )

  echo "[37m
  Black   Red      Green   Yellow    Blue    Magenta   Cyan    White
  -------------------------------------------------------------------[0m"

  for i in (seq 0 7)
    set n (math 30+$i)
  end

end
#}}}

function colorguns  #{{{
#
# ANSI color scheme script by pfh
#
# Initializing mod by lolilolicon from Archlinux
#
# this is modified version
set f1 "[31m"
set f2 "[32m"
set f3 "[33m"
set f4 "[34m"
set f5 "[35m"
set f6 "[36m"
set f7 "[37m"

set bld "[1m"
set rst "[0m"
set inv "[7m"

echo "

$f1 ▀▄▄█████████     $f2 ▀▄▄███████████  $f3 ▀▄▄███████████  $f4 ▀▄▄███████████  $f5 ▀▄▄███████████  $f6 ▀▄▄███████████
$f1 ▄███▀█▀▀▀        $f2 ▄███▀█▀▀▀       $f3 ▄███▀█▀▀▀       $f4 ▄███▀█▀▀▀       $f5 ▄███▀█▀▀▀       $f6 ▄███▀█▀▀▀
$f1▐███▄▀            $f2▐███▄▀           $f3▐███▄▀           $f4▐███▄▀           $f5▐███▄▀           $f6▐███▄▀
$f1▐███              $f2▐███             $f3▐███             $f4▐███             $f5▐███             $f6▐███
$f1 ▀▀▀              $f2 ▀▀▀             $f3 ▀▀▀             $f4 ▀▀▀             $f5 ▀▀▀             $f6 ▀▀▀
$bld
$f1  ▀▄▄███████████  $f2 ▀▄▄███████████  $f3 ▀▄▄███████████  $f4 ▀▄▄███████████  $f5 ▀▄▄███████████  $f6 ▀▄▄███████████
$f1 ▄███▀█▀▀▀        $f2 ▄███▀█▀▀▀       $f3 ▄███▀█▀▀▀       $f4 ▄███▀█▀▀▀       $f5 ▄███▀█▀▀▀       $f6 ▄███▀█▀▀▀
$f1▐███▄▀            $f2▐███▄▀           $f3▐███▄▀           $f4▐███▄▀           $f5▐███▄▀           $f6▐███▄▀
$f1▐███              $f2▐███             $f3▐███             $f4▐███             $f5▐███             $f6▐███
$f1 ▀▀▀              $f2 ▀▀▀             $f3 ▀▀▀             $f4 ▀▀▀             $f5 ▀▀▀             $f6 ▀▀▀
$rst
"
end #}}}


# }}}

# aliases {{{

# gauche alias {{{
if which gosh 1>&-
  function yotsuba
    command gosh yotsuba-get.scm $argv
  end
  function futaba
    command gosh futaba-get.scm $argv
  end
  function danbooru
    command gosh danbooru $argv
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
  function fb
  	gosh fehbrowse.scm $argv
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
#}}}

function pd
  prevd
end
function nd
  nextd $argv
end

if which cdf 1>&-
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
  xlsatoms |  grep '-'
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

function tm
  tmux -u2 a
end

function sc
 screen -U -D -RR  -s /bin/tcsh -m
end


#net {{{
function starwars
  telnet towel.blinkenlights.nl
end
function radio1 -d "BBC Radio 1"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r1.asx
end
function radio2  -d "BBC Radio 2"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r2.asx
end
function radio3 -d "BBC Radio 3"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r3.asx
end
function radio4 -d "BBC Radio 4"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r4.asx
end
function radio6 -d "BBC Radio 6 Music"
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

# command line fu
# torrent search
function tpb
wget -U Mozilla -qO - (echo "http://thepiratebay.org/search/$argv/0/7/0" | sed 's/ /\%20/g') | grep -o 'http\:\/\/torrents\.thepiratebay\.se\/.*\.torrent' # | tac
end

#}}}
#}}}

# keybindings {{{
bind \cd 'delete-char'
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
    sudo make clean
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
    pkg_info -Ea |    xargs -n 1 sudo pkg_create -Jnvb
  end
  function pinfo
    pkg_info -Ix $argv
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
  set PYTHONPATH "~/local/homebrew/lib/python:$PYTHONPATH"
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

# memo
# redirect
#  func 2> /dev/null
#  func ^/dev/null
#  func ^&-
