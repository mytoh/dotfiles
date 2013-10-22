
# environment {{{

ulimit -c 0

shellar.register_paths {$HOME}/local
shellar.push_to_path {$HOME}/.bin
shellar.register_paths {$HOME}/.config/fish

# gentoo prefix {{{
shellar.add_variable EPREFIX {$HOME}/local/gentoo
shellar.push_to_path {$EPREFIX}/tmp/bin {$EPREFIX}/tmp/usr/bin {$EPREFIX}/bin {$EPREFIX}/usr/bin
# }}}

shellar.register_paths {$HOME}/local/homebrew
shellar.push_to_path /usr/local/kde4/bin
shellar.push_to_path ~/local/app/v2c

# haskell package {{{
shellar.register_paths {$HOME}/.cabal
# }}}

# disable home directory completion
set CDPATH .

set -x MANWIDTH 80
if test -d {$HOME}/local/stow
  set -x STOW {$HOME}/local/stow
end
set -x LANG fi_FI.UTF-8
set -x LC_ALL fi_FI.UTF-8
set -x LC_CTYPE fi_FI.UTF-8
set -x MM_CHARSET fi_FI.UTF-8

# pager
set -x LESS "-i  -w -z-4 -g -M -X -F -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-..."

set -x LESS_TERMCAP_md "[01;31m"
set -x LESS_TERMCAP_me "[0m"
set -x LESS_TERMCAP_se "[0m"
set -x LESS_TERMCAP_so "[01;44;33m"
set -x LESS_TERMCAP_ue "[0m"
set -x LESS_TERMCAP_us "[01;32m"

# set default browser
if shellar.command_exists w3m
  set -x BROWSER w3m
end


# editor
if shellar.command_exists vim
  set -x EDITOR vim
end

set -x GREP_OPTIONS "--colour=auto"

# java
set -x _JAVA_OPTIONS -Dawt.useSystemAAFontSettings=on

# rlwrap
set -x RLWRAP_HOME ~/.rlwrap

set -x IGNOREEOF 1

#}}}




function h -d 'cd to directory under home'
  builtin cd {$HOME}/{$argv[1]}
end



function :w
  echo sorry, but this isnt vim
end

function :wq
  :w
end

function :q
  exit
end

function pd
  popd
end

function halt
  sync
  sync
  sync
  sudo shutdown -p now
end

#function sudo
#  sudo -E {$argv}
#end

function xfont
  xlsatoms  | grep --colour=never '-'
end

function xp
  echo "                    name     class "
  xprop  | grep "WM_WINDOW_RULE\|WM_CLASS"
end

function stow
  stow --verbose=3 {$argv}
end

function q
  exit
end


# screen {{{
set -x SCREENDIR {$HOME}/.screen.d/tmp
function sc
  screen -U -D -RR -a -A -m
end
#}}}

# color functions {{{
# functions from
# http://crunchbanglinux.org/forums/post/126921/#p126921

#function colour-pacman #{{{
# set blackf  (tput setaf 0); set redf    (tput setaf 1); set greenf  (tput setaf 2)
# set yellowf (tput setaf 3); set bluef   (tput setaf 4); set purplef (tput setaf 5)
# set cyanf   (tput setaf 6); set whitef  (tput setaf 7)
#
# set blackb  (tput setab 0); set redb    (tput setab 1); set greenb  (tput setab 2)
# set yellowb (tput setab 3); set blueb   (tput setab 4); set purpleb (tput setab 5)
# set cyanb   (tput setab 6); set whiteb  (tput setab 7)
#
# set boldon (tput bold); set boldoff "[22m"
# set italicson (tput sitm); set italicsoff (tput ritm)
# set ulon (tput smul);     set uloff (tput rmul)
# set invon (tput rev);   set invoff (tput rum)
#
# set reset (tput sgr0)
#
# echo "
# $yellowf  ▄███████▄$reset   $redf  ▄██████▄$reset    $greenf  ▄██████▄$reset    $bluef  ▄██████▄$reset    $purplef  ▄██████▄$reset    $cyanf  ▄██████▄$reset
# $yellowf▄█████████▀▀$reset  $redf▄$whitef█▀█$redf██$whitef█▀█$redf██▄$reset  $greenf▄$whitef█▀█$greenf██$whitef█▀█$greenf██▄$reset  $bluef▄$whitef█▀█$bluef██$whitef█▀█$bluef██▄$reset  $purplef▄$whitef█▀█$purplef██$whitef█▀█$purplef██▄$reset  $cyanf▄$whitef█▀█$cyanf██$whitef█▀█$cyanf██▄$reset
# $yellowf███████▀$reset      $redf█$whitef▄▄█$redf██$whitef▄▄█$redf███$reset  $greenf█$whitef▄▄█$greenf██$whitef▄▄█$greenf███$reset  $bluef█$whitef▄▄█$bluef██$whitef▄▄█$bluef███$reset  $purplef█$whitef▄▄█$purplef██$whitef▄▄█$purplef███$reset  $cyanf█$whitef▄▄█$cyanf██$whitef▄▄█$cyanf███$reset
# $yellowf███████▄$reset      $redf████████████$reset  $greenf████████████$reset  $bluef████████████$reset  $purplef████████████$reset  $cyanf████████████$reset
# $yellowf▀█████████▄▄$reset  $redf██▀██▀▀██▀██$reset  $greenf██▀██▀▀██▀██$reset  $bluef██▀██▀▀██▀██$reset  $purplef██▀██▀▀██▀██$reset  $cyanf██▀██▀▀██▀██$reset
# $yellowf  ▀███████▀$reset   $redf▀   ▀  ▀   ▀$reset  $greenf▀   ▀  ▀   ▀$reset  $bluef▀   ▀  ▀   ▀$reset  $purplef▀   ▀  ▀   ▀$reset  $cyanf▀   ▀  ▀   ▀$reset
#
# $boldon$yellowf  ▄███████▄   $redf  ▄██████▄    $greenf  ▄██████▄    $bluef  ▄██████▄    $purplef  ▄██████▄    $cyanf  ▄██████▄$reset
# $boldon$yellowf▄█████████▀▀  $redf▄$whitef█▀█$redf██$whitef█▀█$redf██▄  $greenf▄$whitef█▀█$greenf██$whitef█▀█$greenf██▄  $bluef▄$whitef█▀█$bluef██$whitef█▀█$bluef██▄  $purplef▄$whitef█▀█$purplef██$whitef█▀█$purplef██▄  $cyanf▄$whitef█▀█$cyanf██$whitef█▀█$cyanf██▄$reset
# $boldon$yellowf███████▀      $redf█$whitef▄▄█$redf██$whitef▄▄█$redf███  $greenf█$whitef▄▄█$greenf██$whitef▄▄█$greenf███  $bluef█$whitef▄▄█$bluef██$whitef▄▄█$bluef███  $purplef█$whitef▄▄█$purplef██$whitef▄▄█$purplef███  $cyanf█$whitef▄▄█$cyanf██$whitef▄▄█$cyanf███$reset
# $boldon$yellowf███████▄      $redf████████████  $greenf████████████  $bluef████████████  $purplef████████████  $cyanf████████████$reset
# $boldon$yellowf▀█████████▄▄  $redf██▀██▀▀██▀██  $greenf██▀██▀▀██▀██  $bluef██▀██▀▀██▀██  $purplef██▀██▀▀██▀██  $cyanf██▀██▀▀██▀██$reset
# $boldon$yellowf  ▀███████▀   $redf▀   ▀  ▀   ▀  $greenf▀   ▀  ▀   ▀  $bluef▀   ▀  ▀   ▀  $purplef▀   ▀  ▀   ▀  $cyanf▀   ▀  ▀   ▀$reset
# "
#
#end
# }}}

function colour-invader  #{{{
  set blackf (tput setaf 0)
  set redf (tput setaf 1)
  set greenf (tput setaf 2)
  set yellowf (tput setaf 3)
  set bluef (tput setaf 4)
  set purplef (tput setaf 5)
  set cyanf (tput setaf 6)
  set whitef (tput setaf 7)

  set blackb (tput setab 0)
  set redb (tput setab 1)
  set greenb (tput setab 2)
  set yellowb (tput setab 3)
  set blueb (tput setab 4)
  set purpleb (tput setab 5)
  set cyanb (tput setab 6)
  set whiteb (tput setab 7)

  set boldon (tput bold)
  set boldoff "[22m"
  set italicson (tput sitm)
  set italicsoff (tput ritm)
  set ulon (tput smul)
  set uloff (tput rmul)
  set invon (tput rev)
  set invoff (tput rum)

  set reset (tput sgr0)

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

function colour-dump  #{{{
  set xdef {$HOME}/.xcolours/(grep "xcolours" {$HOME}/.Xresources | sed -re '/^!/d; /^$/d; s/^#include//; s/.*\/([a-z]+)\"$/\1/g;')
  set colours (sed -re '/^!/d; /^$/d; /^#/d; s/(\*colour)([0-9]):/\10\2:/g;' $xdef | grep 'colour[01][0-9]:' | sort |sed 's/^.*: *//g' )

  echo "[37m
  Black   Red      Green   Yellow    Blue    Magenta   Cyan    White
  -------------------------------------------------------------------[0m"

  for i in (seq 0 7)
    set n (math 30+$i)
  end

end
#}}}

function colour-guns  #{{{
  #
  # ANSI colour scheme script by pfh
  #
  # Initializing mod by lolilolicon from Archlinux
  #
  # this is modified version
  set f1 (tput setaf 1)
  set f2 (tput setaf 2)
  set f3 (tput setaf 3)
  set f4 (tput setaf 4)
  set f5 (tput setaf 5)
  set f6 (tput setaf 6)
  set f7 (tput setaf 7)

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
end
#}}}

# }}}
