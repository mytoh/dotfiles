
# environment {{{

ulimit -c 0

set -ge PATH
set -gx PATH  /usr/local/{sbin,bin} /{sbin,bin} /usr/{sbin,bin} /usr/games/ $PATH

function push-to-path
    for p in $argv
      if test -d $p
        if not contains $p $PATH
          set -gx PATH $p $PATH
        end
      end
    end
end

# gentoo prefix {{{
set -x EPREFIX $HOME/local/gentoo
push-to-path $EPREFIX/tmp/bin $EPREFIX/tmp/usr/bin $EPREFIX/bin $EPREFIX/usr/bin
# }}}

push-to-path /usr/local/kde4/bin $HOME/local/homebrew/{sbin,bin} $HOME/local/{sbin,bin}

# haskell package {{{
push-to-path $HOME/.cabal/bin
# }}}

# disable home directory completion
set CDPATH .

set -x MANWIDTH 80
if test -d $HOME/local/stow
  set -x STOW $HOME/local/stow
end
set -x LANG       fi_FI.UTF-8
set -x LC_ALL     fi_FI.UTF-8
set -x LC_CTYPE   fi_FI.UTF-8
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
if which w3m 1>  /dev/null
  set -x BROWSER w3m
end

# editor
if which vim 1> /dev/null
set -x EDITOR vim
end

set -x GREP_OPTIONS "--colour=auto"

# java
set -x _JAVA_OPTIONS -Dawt.useSystemAAFontSettings=on

# rlwrap
set -x RLWRAP_HOME ~/.rlwrap

set -x IGNOREEOF 1

#}}}

# complete {{{
function push-to-comp-path
set -l comp-directory ~/local/git
  for p in $argv
    if test -d $comp-directory/$p
      if not contains $comp-directory/$p $fish_complete_path
        set fish_complete_path $comp-directory/$p $fish_complete_path
      end
    end
  end
end
push-to-comp-path fish-nuggets/completions fish_completions/ fishystuff/completions


# h function {{{
complete -x -c h -a "(__fish_complete_cd)"
complete -x -c h -a "(__fish_complete_directories $HOME)"
complete -c h -s h -l help --description 'Display help and exit'
# }}}

#}}}

# gauche {{{


set    GAUCHE_ARCH (gauche-config --arch)
set -x GAUCHE_LOAD_PATH "$HOME/.gosh:$HOME/.gosh/skripti:$HOME/local/share/gauche-0.9/site/lib:$HOME/local/lib/gauche-0.9/site/$GAUCHE_ARCH"


# gauche completions {{{

# gosh {{{
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

# panna {{{
# add panna to PATH
set -x OLUTPANIMO "$HOME/.panna"
set -x GAUCHE_LOAD_PATH $OLUTPANIMO/kirjasto:$GAUCHE_LOAD_PATH
push-to-path $OLUTPANIMO/bin
if test ! -L $OLUTPANIMO/bin/panna
  ln -sf $OLUTPANIMO/kirjasto/run-panna.scm $OLUTPANIMO/bin/panna
end

function __fish_complete_panna_kaava
  set arguments (commandline -opc)
  set path (echo $OLUTPANIMO | tr ':' '\n')

  for cmd in $arguments

    if contains -- $cmd edit install homepage home up update
      ls $OLUTPANIMO/kirjasto/kaava | sed s/\.scm//
      return 0
    end

    if contains -- $cmd abv info list ls rm remove unlink uninstall
      ls $OLUTPANIMO/kellari
      return 0
    end
  end
end

complete -c panna -n '__fish_use_subcommand' -xa 'build install up edit info
uninstall  unlink rm remove ls list homepage home up update'
complete -c panna -f -a "(__fish_complete_panna_kaava)"
# }}}

# talikko {{{
function __fish_complete_talikko_ports_tree
  set arguments (commandline -opc)
  set path (echo $OLUTPANIMO | tr ':' '\n')

  for cmd in $arguments
    if contains -- $cmd install
      set -l path /usr/ports/*
      for i in $path
        if test -d $i
        echo (basename $i)
        end
      end
      return 0
    end
  end
end

complete -c talikko -n '__fish_use_subcommand' -xa 'install reinstall update up search'
complete -c talikko -f -a "(__fish_complete_talikko_ports_tree)"
complete -c tl -n '__fish_use_subcommand' -xa 'install reinstall update up search'
complete -c tl -f -a "(__fish_complete_talikko_ports_tree)"
#}}}

#}}}

# gauche functions {{{
if which gosh >&-

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

        function gi
                rlwrap -c -q '"' -b '(){}[].,#@;|`"' gosh repl.scm $argv
       end

       function tl
                command gosh talikko.scm $argv
       end

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
                command gosh fehbrowse.scm $argv
        end

        function talikko
                command gosh talikko.scm $argv
        end

        function colour-numbers
                command gosh colour-numbers.scm
        end

        function colour-pacman
                command gosh colour-pacman.scm
        end

        function fi-en
                command gosh kääntää.scm fi en $argv[1]
        end

        function en-fi
                command gosh kääntää.scm en fi $argv[1]
        end

        function fi-ja
                command gosh kääntää.scm fi ja $argv[1]
        end

        function sanoa
                command gosh sanoa.scm $argv
        end

        function v
                command gosh v.scm $argv
        end

        function a
                command gosh launch-app.scm $argv
        end
        complete -c a -a "(complete -C(commandline -ct))" -x

        function hub
              command gosh hub.scm $argv
        end

        function tm
                command gosh tmux-start.scm
        end

        function urxvtcd
                command gosh urxvtcd.scm
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

#}}}

# fish variables {{{
set fish_greeting ""
# colors {{{
# black, red, green, brown, yellow,
# blue, magenta, purple, cyan, white, normal
set fish_color_normal         normal
set fish_color_command        cyan
set fish_color_comment     -o white
set fish_color_cwd            blue
set fish_color_end            cyan
set fish_color_error          red
set fish_color_match          magenta
set fish_color_param          magenta
set fish_color_redirection    yellow
set fish_color_search_match   brown
set fish_color_substitution   green
set fish_color_operator       cyan
set fish_color_escape         purple
set fish_color_quote          purple
set fish_color_valid_path     brown

set fish_pager_color_completion  brown
set fish_pager_color_description yellow
set fish_pager_color_prefix      magenta
set fish_pager_color_progress    green
#}}}

#}}}

# prompt {{{
set open_paren "[30m([0m"
set close_paren "[30m)[0m"

#  arch wiki git status prompt {{{
set fish_git_dirty_colour red
function parse_git_dirty
  git diff --quiet HEAD 2>&-
  if test $status = 1
    echo (set_color $fish_git_dirty_colour)"÷"(set_color normal)
  end
end

function parse_git_branch
  # git branch outputs lines, the current branch is prefixed with a *
  set -l branch (git branch --color | awk '{print $2}')
  echo $branch (parse_git_dirty)
end

function git_prompt
  if test -z (git branch --quiet 2>| awk '/fatal:/ {print "no git"}')
    printf '%s%s' (parse_git_branch) (set_color $fish_color_normal)
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
  switch "$PWD"
  case "/usr$HOME"
    printf '%s%s%s' (set_color $fish_color_cwd) (echo '~') (set_color $fish_color_normal)
  case "/usr$HOME/*"
    printf '%s%s%s' (set_color $fish_color_cwd) (echo $PWD|sed -e "s|^/usr$HOME|~|") (set_color $fish_color_normal)
  case '*'
    printf '%s%s%s' (set_color $fish_color_cwd) (echo $PWD) (set_color $fish_color_normal)
  end

  #printf '%s%s%s' (set_color $fish_color_cwd) (prompt_pwd_mod) (set_color $fish_color_normal)
end

function prompt-up-right
  printf '%s%s' "[30m┌─[0m"
end

function prompt-down-right
  printf '%s%s' "[30m└┈╸[0m"
end

function prompt-host
  printf '%s%s%s' "[38;5;118m" (hostname -s) (set_color $fish_color_normal)
end

function prompt-face
#if test $status = 1
#  printf '%s%s%s' "[38;5;196m" "(・X・)" (set_color $fish_color_normal)
#else
  printf '%s%s%s' "[38;5;172m" "X / _ / X" (set_color $fish_color_normal)
#end
end

function prompt-arrow
printf '%s%s%s' "[38;5;235m>"  "[38;5;67m>"   "[38;5;117m>"
end



function fish_prompt -d "fish prompt with gauche script"
 gosh prompt.scm
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


function cdl -d 'cd to the last path'
  cd $last_cwd
end

function h -d 'cd to directory under home'
  builtin cd $HOME/$argv[1]
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

function :w
echo sorry, but this isnt vim
end

function :wq
:w
end

function :q
exit
end

function mps
 #play hd h.264 on slow computer
   mplayer -vfm ffmpeg -lavdopts lowres=2:fast:skiploopfilter=all:threads=2 $argv
end


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

function colour-invader #{{{
 set blackf  (tput setaf 0); set redf    (tput setaf 1); set greenf  (tput setaf 2)
 set yellowf (tput setaf 3); set bluef   (tput setaf 4); set purplef (tput setaf 5)
 set cyanf   (tput setaf 6); set whitef  (tput setaf 7)

 set blackb  (tput setab 0); set redb    (tput setab 1); set greenb  (tput setab 2)
 set yellowb (tput setab 3); set blueb   (tput setab 4); set purpleb (tput setab 5)
 set cyanb   (tput setab 6); set whiteb  (tput setab 7)

 set boldon (tput bold); set boldoff "[22m"
 set italicson (tput sitm); set italicsoff (tput ritm)
 set ulon (tput smul);     set uloff (tput rmul)
 set invon (tput rev);   set invoff (tput rum)

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
  set xdef $HOME/.xcolours/(grep "xcolours" $HOME/.Xresources | sed -re '/^!/d; /^$/d; s/^#include//; s/.*\/([a-z]+)\"$/\1/g;')
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
end #}}}


# }}}

# aliases {{{



function pd
  popd
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

function xp
  echo         "                    name     class "
  xprop | grep "WM_WINDOW_RULE\|WM_CLASS"
end

function rr
  command rm -rf $argv
end

function mkd
  command mkdir -p $argv
end

function stow
  stow --verbose=3 $argv
end


function q
exit
end
function load_lol_aliases
        # taken from oh-my-zsh
        # Source: http://aur.archlinux.org/packages/lolbash/lolbash/lolbash.sh

        alias wtf 'dmesg'
        alias onoz 'cat /var/log/errors.log'
        alias rtfm 'man'

        alias visible 'echo'
        alias invisible 'cat'
        alias moar 'more'
        alias tldr 'less'
        alias alwayz 'tail -f'

        alias icanhas 'mkdir'
        alias gimmeh 'touch'
        alias donotwant 'rm'
        alias dowant 'cp'
        alias gtfo 'mv'
        alias nowai 'chmod'

        alias hai 'cd'
        alias iz 'ls'
        alias plz 'pwd'
        alias ihasbucket 'df -h'

        alias inur 'locate'
        alias iminurbase 'finger'

        alias btw 'nice'
        alias obtw 'nohup'

        alias nomz 'ps -aux'
        alias nomnom 'killall'

        alias byes 'exit'
        alias cya 'reboot'
        alias kthxbai 'halt'
end
load_lol_aliases


# screen {{{
set -x SCREENDIR $HOME/.screen.d/tmp
function sc
 screen -U -D -RR -a -A -m
end
#}}}


#net {{{
function starwars
  telnet towel.blinkenlights.nl
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

function load-radio-functions 
# bbc radio {{{
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
#}}}
# japani radio {{{
#
# taken from
# <http://junk.s21.xrea.com/scripts/alias-sradio.txt>

### for Podcasting, Streaming, FM, Radio   (UTF-8)                  2011/11/21
# 24時間放送でないところは、放送時間を確認してから聞いて下さい。

# NHK
function sb-nhkr1 -d "NHK第一"
mplayer -playlist http://mfile.akamai.com/129931/live/reflector:46032.asx
end
function sb-nhkr2  -d "NHK第二"
mplayer -playlist http://mfile.akamai.com/129932/live/reflector:46056.asx
end
function sb-nhkfm  -d "NHK-FM"
mplayer -playlist http://mfile.akamai.com/129933/live/reflector:46051.asx
end

# FMわっぴ〜             (北海道稚内市)
function sb-wappy -d "FMわっぴ〜 (北海道稚内市)"
mplayer mms://fmwappy.aa0.netvolante.jp:8080
end
function sb-wakkanai -d "FMわっぴ〜 (北海道稚内市)"
sb-wappy
end

# FMりべーる             (北海道旭川市)
function sb-837 -d  "FMりべーる (北海道旭川市)"
mplayer http://wms.shibapon.net/fm837
end
function sb-asahikawa -d  "FMりべーる (北海道旭川市)"
sb-837
end

# FM Dramacity           (北海道札幌市厚別区)
function sb-dramacity -d "FM Dramacity (北海道札幌市厚別区)"
mplayer -novideo http://bipscweb.ddo.jp:8080/
end
function sb-sapporod -d "FM Dramacity (北海道札幌市厚別区)"
sb-dramacity
end

# 三角山放送局           (北海道札幌市西区)
function sb-sankakuyama -d "三角山放送局  (北海道札幌市西区) "
mplayer -playlist http://wm.sankakuyama.co.jp/asx/sankaku_24k.asx
end
function sb-sapporos  -d "三角山放送局  (北海道札幌市西区) "
sb-sankakuyama
end

# FM-JAGA                (北海道帯広市)
function sb-jaga -d "FM-JAGA  (北海道帯広市) "
mplayer mms://simul.freebit.net/fmjaga
end
function sb-obihiroj -d "FM-JAGA  (北海道帯広市) "
sb-jaga
end

# FM WING                (北海道帯広市)
function sb-wing   -d "FM WING (北海道帯広市)"
mplayer mms://simul.freebit.net/fmwing
end
function sb-obihirow -d "FM WING (北海道帯広市)"
sb-wing
end

# FMくしろ               (北海道釧路市)
function sb-kushiro -d "FMくしろ (北海道釧路市)"
mplayer -playlist http://www.simulradio.jp/asx/FmKushiro.asx
end

# ラヂオもりおか         (岩手県盛岡市)
function sb-morioka -d "ラヂオもりおか (岩手県盛岡市)"
mplayer mms://simul.freebit.net/radiomorioka
end

# 横手かまくらエフエム   (秋田県横手市)
function sb-yokote -d "横手かまくらエフエム (秋田県横手市)"
mplayer -playlist http://www.simulradio.jp/asx/FmYokote.asx
end

# FMゆーとぴあ  24時間   (秋田県湯沢市)
function sb-yutopia -d "FMゆーとぴあ  24時間   (秋田県湯沢市)"
mplayer -playlist http://www.simulradio.jp/asx/FmYutopia.asx
end
function sb-yuzawa -d "FMゆーとぴあ  24時間   (秋田県湯沢市)"
sb-yutopia
end

# ラジオ石巻             (宮城県石巻市)
function sb-ishinomaki -d "ラジオ石巻             (宮城県石巻市)"
mplayer -playlist http://www.simulradio.jp/asx/RadioIshinomaki.asx
end

# fmいずみ               (宮城県仙台市)
function sb-izumi -d "fmいずみ               (宮城県仙台市)"
mplayer -playlist http://www.simulradio.jp/asx/fmIzumi.asx
end
function sb-sendaii -d "fmいずみ               (宮城県仙台市)"
sb-izumi
end

# RADIO3                 (宮城県仙台市)
function sb-radio3 -d "RADIO3 (宮城県仙台市)"
mplayer mms://simul.freebit.net/radio3
end
function sb-sendai3  -d "RADIO3 (宮城県仙台市)"
sb-radio3
end

# FM Mot.com             (福島県本宮市)
function sb-motcom -d "FM Mot.com (福島県本宮市)"
mplayer mms://simul.freebit.net/fmmotcom
end
function sb-motomiya -d "FM Mot.com (福島県本宮市)"
sb-motcom
end
# エフエム会津           (福島県会津若松市)
function sb-aizu -d "エフエム会津 (福島県会津若松市)"
mplayer -playlist http://www.simulradio.jp/asx/FmAizu.asx
end
# 郡山コミュニティ放送   (福島県郡山市)
function sb-koco -d "郡山コミュニティ放送   (福島県郡山市)"
mplayer -playlist http://www.simulradio.jp/asx/kocofm.asx
end
function sb-koriyama -d "郡山コミュニティ放送   (福島県郡山市)"
sb-koco
end
# FMいわき               (福島県いわき市)
function sb-iwaki -d "FMいわき (福島県いわき市)"
mplayer http://wms.shibapon.net/SeaWaveFmIwaki
end

# FMぱるるん             (茨城県水戸市)
function sb-palulun -d "FMぱるるん (茨城県水戸市)"
mplayer -playlist http://www.simulradio.jp/asx/FmPalulun.asx
end
function sb-mito -d "FMぱるるん (茨城県水戸市)"
sb-palulun
end
# ラヂオつくば  24時間   (茨城県つくば市)
function sb-tsukuba -d "ラヂオつくば  24時間   (茨城県つくば市)"
mplayer -novideo mms://ir298.com/IRTsukuba/radiotsukuba.asx
end
# エフエムかしま         (茨城県鹿嶋市)
function sb-kashima -d "エフエムかしま (茨城県鹿嶋市)"
mplayer -playlist http://www.simulradio.jp/asx/FmKashima.asx
end

# FM桐生                 (群馬県桐生市)
function sb-kiryu -d "FM桐生 (群馬県桐生市)"
mplayer http://wms.shibapon.net/kiryu.fm
end
# まえばしCITYエフエム  24時間   (群馬県前橋市)
function sb-maebashi -d "まえばしCITYエフエム  24時間   (群馬県前橋市)"
mplayer http://radio.maebashi.fm:8080/mwave
end

# かずさエフエム         (千葉県木更津市)
function sb-kazusa -d "かずさエフエム (千葉県木更津市)"
mplayer -playlist http://www.simulradio.jp/asx/KazusaFM.asx
end
function sb-kisarazu -d "かずさエフエム (千葉県木更津市)"
sb-kazusa
end

# フラワーラジオ         (埼玉県鴻巣市)
function sb-flower -d "フラワーラジオ (埼玉県鴻巣市)"
mplayer http://wms.shibapon.net/flower
end
function sb-kounosu  -d "フラワーラジオ (埼玉県鴻巣市)"
sb-flower
end
# REDS WAVE              (埼玉県さいたま市浦和区)
function sb-redswave -d "REDS WAVE              (埼玉県さいたま市浦和区)"
mplayer http://wms.shibapon.net/reds-wave
end
# SMILE FM    24時間     (埼玉県朝霞市)
function sb-smile -d "SMILE FM 24時間 (埼玉県朝霞市)"
mplayer mms://simul.freebit.net/smilefm
end
function sb-asaka -d "SMILE FM 24時間 (埼玉県朝霞市)"
sb-smile
end

# かつしかFM  24時間     (東京都葛飾区)
function sb-katsushika -d "かつしかFM 24時間 (東京都葛飾区)"
mplayer -playlist http://www.simulradio.jp/asx/KatsushikaFM.asx
end
# レインボータウンFM     (東京都江東区)
function sb-rainbowtown -d "レインボータウンFM (東京都江東区)"
mplayer -playlist http://www.simulradio.jp/asx/RainbowtownFM.asx
end
# むさしのFM             (東京都武蔵野市)
function sb-musashino -d "むさしのFM (東京都武蔵野市)"
mplayer -playlist http://www.simulradio.jp/asx/MusashinoFM.asx
end
# FM 西東京   24時間     (東京都西東京市)
function sb-nishitokyo -d "FM 西東京 24時間 (東京都西東京市)"
mplayer http://wms.shibapon.net/FmNishiTokyo
end
# FM たちかわ            (東京都立川市)
function sb-tachikawa -d "FM たちかわ (東京都立川市)"
mplayer http://wms.shibapon.net/FmTachikawa
end
# 調布FM      24時間     (東京都調布市)
function sb-chofu -d "調布FM 24時間 (東京都調布市)"
mplayer -playlist http://www.simulradio.jp/asx/ChofuFM.asx
end

# かわさきFM             (神奈川県川崎市)
function sb-kawasaki -d "かわさきFM (神奈川県川崎市)"
mplayer http://wms.shibapon.net/FM_K-City
end
# FMサルース             (神奈川県横浜市)
function sb-salus -d "FMサルース (神奈川県横浜市)"
mplayer -playlist http://www.simulradio.jp/asx/FmSalus.asx
end
# FM戸塚                 (神奈川県横浜市)
function sb-totsuka -d "FM戸塚 (神奈川県横浜市)"
mplayer http://wms.shibapon.net/FmTotsuka
end

# FMやまと               (神奈川県大和市)
function sb-yamato -d "FMやまと (神奈川県大和市)"
mplayer http://wms.shibapon.net/FMYamato
end

# 湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)
function sb-shonanbeach -d "湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)"
mplayer mms://simul.freebit.net/shonanbeachfma
end
function sb-hayama -d "湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)"
sb-shonanbeach
end

# レディオ湘南           (神奈川県藤沢市)
function sb-radioshonan -d "レディオ湘南 (神奈川県藤沢市)"
mplayer mms://simul.freebit.net/radioshonan
end
function sb-fujisawa -d "レディオ湘南 (神奈川県藤沢市)"
sb-radioshonan
end
# エフエムさがみ         (神奈川県相模原市)
function sb-sagami -d "エフエムさがみ (神奈川県相模原市)"
mplayer -novideo -playlist http://www.fmsagami.co.jp/asx/fmsagami.asx
end
# FMおだわら  24時間     (神奈川県小田原市)
function sb-odawara -d "FMおだわら 24時間 (神奈川県小田原市)"
mplayer mms://simul.freebit.net/fmodawara
end

# FM Kento               (新潟県新潟市)
function sb-kento -d "FM Kento (新潟県新潟市)"
mplayer mms://simul.freebit.net/fmkento
end
function sb-niigata -d "FM Kento (新潟県新潟市)"
sb-kento
end
# FM PIKKARA             (新潟県柏崎市)
function sb-pikkara -d "FM PIKKARA (新潟県柏崎市)"
mplayer -novideo -playlist http://www.happy-kashiwazaki.com/pikkara/livekcb.asx
end
function sb-kashiwazaki -d "FM PIKKARA (新潟県柏崎市)"
sb-pikkara
end

# FM軽井沢    24時間     (長野県軽井沢町)
function sb-karuizawa -d "FM軽井沢 24時間 (長野県軽井沢町)"
mplayer mms://simul.freebit.net/fmkaruizawa
end

# FMかほく    24時間     (石川県かほく市)
function sb-kahoku -d "FMかほく 24時間 (石川県かほく市)"
mplayer http://radio.kahoku.net:8000/
end
# ハーバーステーション   (福井県敦賀市)
function sb-harbor779
mplayer (wget -O - http://www.web-services.jp/harbor779/radio.html | sed -n '/mp3/s/^.*\(http:[^;]*\).*$/\1/p')
end
function sb-tsuruga
sb-harbor779
end

# エフエム熱海湯河原     (静岡県熱海市)
function sb-ciao -d "エフエム熱海湯河原     (静岡県熱海市)"
mplayer http://simul.freebit.net:8310/ciao
end

function sb-atami
sb-ciao
end

# FMおかざき             (愛知県岡崎市)
function sb-okazaki -d "FMおかざき             (愛知県岡崎市)"
mplayer -playlist http://www.simulradio.jp/asx/FmOkazaki.asx
end
# MID-FM                 (愛知県名古屋市)
function sb-mid
mplayer http://wms.shibapon.net/mid-fm761
end
function sb-nagoya
sb-mid
end
# PORT WAVE              (三重県四日市)
function sb-portwave
mplayer -playlist http://www.p-wave.ne.jp/live/wmedia/portwave.asx
end
function sb-yokkaichi
sb-portwave
end

# FMいかる               (京都府綾部市)
function sb-ikaru
mplayer http://wms.shibapon.net/FMIkaruAtAyabe
end
function sb-ayabe
sb-ikaru
end
# FM CASTLE   24時間     (京都府福知山市)
function sb-castle
mplayer (wget -O - http://www.fm-castle.jp/simul.asx | sed -n 's/^.*\(mms:[^\]*\).*$/\1/p')
end
function sb-fukuchiyama
sb-castle
end

# FMひらかた  24時間     (大阪府枚方市)
function sb-hirakata
mplayer http://wms.shibapon.net/Fmhirakata
end
# みのおエフエム  24時間 (大阪府箕面市)
function sb-minoh
mplayer -playlist http://fm.minoh.net/minohfm.asx
end
# FM千里                 (大阪府豊中市)
function sb-senri
mplayer http://simul.freebit.net:8310/fmsenri
end
# FM HANAKO              (大阪府守口市)
function sb-hanako
mplayer -novideo (wget -O - http://fmhanako.jp/radio/824.asx | sed -n '/mms/{s/^.*\(mms:[^\]*\).*$/\1/p; q;}')
end
function sb-moriguchi
sb-hanako
end
# ウメダFM Be Happy! 789  24時間  (大阪府大阪市)
function sb-umeda
mplayer -playlist http://www.simulradio.jp/asx/FmKita.asx
end
# YES-fm                          (大阪府大阪市中央区)
function sb-yes
mplayer -playlist http://www.simulradio.jp/asx/YesFM.asx
end
function sb-nanba
sb-yes
end

# FM JUNGLE   24時間     (兵庫県豊岡市)
function sb-jungle
mplayer http://wms.shibapon.net/FmJungle
end
function sb-toyooka
sb-jungle
end
# FM宝塚                 (兵庫県宝塚市)
function sb-takarazuka
mplayer -playlist http://www.simulradio.jp/asx/FmTakarazuka.asx
end
# FMわぃわぃ             (兵庫県神戸市)
function sb-yy
mplayer http://simul.freebit.net:8310/fmyy
end
# エフエムみっきぃ       (兵庫県三木市)
function sb-miki
mplayer http://wms.shibapon.net/FmMiki
end
# BAN-BANラジオ  24時間  (兵庫県加古川市)
function sb-banban
mplayer http://wms.shibapon.net/BAN-BAN_Radio
end
function sb-kakogawa
sb-banban
end
# FM GENKI               (兵庫県姫路市)
function sb-genki
mplayer http://wms.shibapon.net/FmGenki
end
function sb-himeji
sb-genki
end

# BananaFM    24時間     (和歌山県和歌山市)
function sb-banana
mplayer http://wms.shibapon.net/BananaFM
end
function sb-wakayama
sb-banana
end
# FM TANABE              (和歌山県田辺市)
function sb-tanabe
mplayer http://wms.shibapon.net/FmTanabe
end
# FMビーチステーション   (和歌山県白浜町)
function sb-beachstation
mplayer -playlist http://www.simulradio.jp/asx/BeachStation.asx
end
function sb-shirahama
sb-beachstation
end

# DARAZ FM               (鳥取県米子市)
function sb-daraz
mplayer -playlist http://www.darazfm.com/streaming.asx
end
function sb-yonago
sb-daraz
end
# エフエムつやま         (岡山県津山市)
function sb-tsuyama
mplayer -playlist http://www.tsuyama.tv/encoder/fmtsuyamalive.ram
end
# FMちゅーピー           (広島県広島市)
function sb-chupea
mplayer http://wms.shibapon.net/FmChuPea
end
function sb-hiroshima
sb-chupea
end

# FM高松                 (香川県高松市)
function sb-takamatsu
mplayer http://wms.shibapon.net/FmTakamatsu
end
# FMびざん               (徳島県徳島市)
function sb-bfm
mplayer http://wms.shibapon.net/B-FM791
end
function sb-tokushima
sb-bfm
end

# FM KITAQ               (福岡県北九州市)
function sb-kitaqk
mplayer -playlist http://www.simulradio.jp/asx/FmKitaq.asx
end
# AIR STATION HIBIKI     (福岡県北九州市)
function sb-hibiki
mplayer -playlist http://std1.ladio.net:8000/soxisix37494.m3u
end
function sb-kitaqw
sb-hibiki
end
# FMしまばら             (長崎県島原市)
function sb-shimabara
mplayer mms://st1.shimabara.jp/fmlive
end
# NOAS FM                (大分県中津市)
function sb-noas
mplayer mms://simul.freebit.net/fmnakatsu
end
function sb-nakatsu
sb-noas
end
# SunshineFM             (宮崎県宮崎市)
function sb-sunshine
mplayer mms://simul.freebit.net/sunshinefm
end
function sb-miyazaki
sb-sunshine
end
# おおすみ半島FM 24時間  (鹿児島県鹿屋市)
function sb-osumi
mplayer -af volume 10:0 -playlist http://fm.osumi.or.jp:8000/0033FM.m3u
end
# あまみFM               (鹿児島県奄美市)
function sb-amami
mplayer -playlist http://www.simulradio.jp/asx/AmamiFM.asx
end

# FMうるま       24時間  (沖縄県うるま市)
function sb-uruma -d "FMうるま 24時間  (沖縄県うるま市)"
mplayer -playlist http://www.simulradio.jp/asx/FmUruma.asx
end
# FMニライ               (沖縄県北谷町) ちゃたんちょう
function sb-nirai -d  "FMニライ               (沖縄県北谷町) ちゃたんちょう"
mplayer http://wms.shibapon.net/FmNirai
end
function sb-chatan
sb-nirai
end
# FM21           24時間  (沖縄県浦添市)
function sb-fm21
mplayer -playlist http://www.simulradio.jp/asx/Fm21inOkinawa.asx
end
# FMレキオ       24時間  (沖縄県那覇市)
function sb-lequio
mplayer -playlist http://www.simulradio.jp/asx/FmLequio.asx
end
# FMとよみ               (沖縄県豊見城市)
function sb-toyomi
mplayer -playlist http://www.simulradio.jp/asx/FmToyomi.asx
end
function sb-tomigusuku
sb-toyomi
end
#}}}
end
load-radio-functions

# command line fu
# torrent search
function tpb
wget -U Mozilla -qO - (echo "http://thepiratebay.org/search/$argv/0/7/0" | sed 's/ /\%20/g') | grep -o 'http\:\/\/torrents\.thepiratebay\.se\/.*\.torrent' # | tac
end

#}}}
#}}}

# keybindings {{{
#bind --erase \cd
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
  set -x DYLD_FALLBACK_LIBRARY_PATH "$HOME/local/lib:$HOME/local/homebrew/lib"
  set -x LD_LIBRARY_PATH /usr/local/linux-sun-jdk1.6.0/jre/lib/i386
  set -x SDL_VIDEODRIVER vgl
  # PACKAGESITE="ftp://ftp.jp.FreeBSD.org/pub/FreeBSD/ports/i386/packages/Latest/"
  function pcheck
    sudo portmaster -PBidav $argv
    sudo portaudit -Fdav
    sudo portmaster -y --clean-packages --clean-distfiles
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

# mac settings
  case Darwin
  push-to-path /opt/X11/bin /usr/x11/bin 
  set -x DYLD_FALLBACK_LIBRARY_PATH "$HOME/local/lib:$HOME/local/homebrew/lib:/usr/lib:/usr/local/lib:/Library/Frameworks/Mono.frameworks/Libraries"
  #set -x LD_LIBRARY_PATH /usr/local/linux-sun-jdk1.6.0/jre/lib/i386
  set PYTHONPATH "~/local/homebrew/lib/python:$PYTHONPATH"
  set -x TERM xterm-256color

  function fish_prompt -d "fish prompt function"
    #printf '%s%s%s%s\n%s ' (prompt-up-right) (current-directory) (set_color normal) (git_prompt) (prompt-down-right)
    if test -d $PWD/.git
    printf '%s.%s :: %s:%s\n%s ' (prompt-face) (prompt-host) (current-directory) (git_prompt)  (prompt-arrow)
    else
    printf '%s.%s :: %s\n%s ' (prompt-face) (prompt-host) (current-directory) (prompt-arrow)
    end
  end

  xsource (brew --prefix)/Library/Contributions/brew_fish_completion.fish
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
  set -x HOMEBREW_VERBOSE 1
  set -x HOMEBREW_USE_CLANG 1
  set -x JAVA_HOME ~/Library/JAVA/JavaVirtualMachines/1.7.0.jdk/Contents/Home
end
#}}}

#{{{
#if test -e $HOME/.gosh/terminal-title.scm
#  if which gosh 1>  /dev/null
#     gosh $HOME/.gosh/terminal-title.scm &
#  end
#end
#  }}}

# }}}

# memo
# redirect
#  func 2> /dev/null
#  func ^/dev/null
#  func ^&-

# vim: foldmethod=marker
