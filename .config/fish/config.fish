
function xsource
  for i in $argv
    if test  $i
      . $i
    end
  end
end


. ~/.config/fish/function.fish
. ~/.config/fish/environment.fish
. ~/.config/fish/gauche.fish

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


# fish variables {{{
set fish_greeting ""
# colors {{{
# black, red, green, brown, yellow,
# blue, magenta, purple, cyan, white, normal
set fish_color_normal         normal
set fish_color_command        cyan
set fish_color_comment     -o yellow
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
  xsource ~/.config/fish/freebsd.fish

# mac settings
  case Darwin
  push-to-path /opt/X11/bin /usr/x11/bin 
  set -x DYLD_FALLBACK_LIBRARY_PATH "$HOME/local/lib:$HOME/local/homebrew/lib:/usr/lib:/usr/local/lib:/Library/Frameworks/Mono.frameworks/Libraries"
  #set -x LD_LIBRARY_PATH /usr/local/linux-sun-jdk1.6.0/jre/lib/i386
  set PYTHONPATH "~/local/homebrew/lib/python:$PYTHONPATH"
  set -x TERM xterm-256color

  #function fish_prompt -d "fish prompt function"
  #  #printf '%s%s%s%s\n%s ' (prompt-up-right) (current-directory) (set_color normal) (git_prompt) (prompt-down-right)
  #  if test -d $PWD/.git
  #  printf '%s.%s :: %s:%s\n%s ' (prompt-face) (prompt-host) (current-directory) (git_prompt)  (prompt-arrow)
  #  else
  #  printf '%s.%s :: %s\n%s ' (prompt-face) (prompt-host) (current-directory) (prompt-arrow)
  #  end
  #end

  function fish_prompt -d "fish prompt with gauche script"
   gosh prompt.scm
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
