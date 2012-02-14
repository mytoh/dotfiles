#!/bin/sh

# ibus {{{
export XIM="ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="xim"
export XMODIFIERS=@im="ibus"
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="-r --daemonize --xim"
ibus-daemon -d -x &
# }}}

# uim {{{
# uim-xim &
# export GTK_IM_MODULE="uim"
# export QT_IM_MODULE="uim"
# export XMODIFIERS=@im=uim
# export UIM_CANDWIN_PROG=uim-candwin-gtk
#}}}

export PATH="$HOME/local/bin:$PATH"
xrdb -merge $HOME/.Xresources
setxkbmap dvorak
xmodmap $HOME/.xmodmap
xset b off # turn off beep
xset r rate 200 30
xsetroot -cursor_name right_ptr &
xset fp+ /usr/local/lib/X11/fonts/local
xset fp+ /usr/local/lib/X11/fonts/TrueType
xset fp+ /usr/local/lib/X11/fonts/cyrillic
xset fp+ /usr/local/lib/X11/fonts/profont
xset fp+ /usr/local/lib/X11/fonts/terminus-font
xset fp+ /usr/local/lib/X11/fonts/bitstream-vera
xset fp+ /usr/local/lib/X11/fonts/dejavu
xset fp+ /usr/local/lib/X11/fonts/Droid
xset fp+ /usr/local/lib/X11/fonts/artwiz-aleczapka-en
xset fp+ $HOME/.fonts
xset fp rehash
urxvtcd &
xbindkeys &
Thunar --daemon &
spiffy &
#parcellite &
gosh makiki-server.scm &
tracker-applet &

if [ "$1" = "twm" -o "$1" = "openbox" -o "$1" = "flwm" ]; then
  $HOME/.dzen/bin/status | dzen2 -p -ta l -w 1160 -h 16 -bg gray15 -fn '-*-terminus-medium-r-normal--12-*' -e 'onexit=ungrabmouse' &
  trayer --expand false --alpha 20  --tint 0x606060 --transparent true --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 7 --widthtype pixel --width 120 &
  #sleep 20 && wbar -above-desk -bpress -isize 45 -balfa 20 -nanim 9 &
  if [ -f $HOME/.fehbg ]; then
    $HOME/.fehbg &
  else
    feh --bg-max ~/.wallpaper &
  fi
  fbpanel &
fi

DEFAULT_SESSION="dwm"
case $1 in
  stumpwm) exec stumpwm ;;
  sawfish) exec ck-launch-session sawfish ;;
  xmonad) exec xmonad ;;
  twm) exec twm -v ;;
  xfce) exec ck-launch-session startxfce4 ;;
  fluxbox) exec startfluxbox ;;
  flwm) exec flwm ;;
  qvwm) exec qvwm ;;
  fvwm|fvwm2) exec fvwm2 ;;
  fvwm-themes*) exec fvwm-themes-start -s sa ;;
  dwm) exec $HOME/.dwm/startdwm ;;
  swm) exec swm ;;
  afterstep) exec afterstep ;;
  awesome) exec awesome ;;
  kde) exec startkde4 ;;
  gnome) exec gnome-session ;;
  openbox) exec openbox ;;
  wmaker)   exec wmaker ;;
  oroborus)   exec oroborus ;;
  mate) exec ck-launch-session mate-session ;;
  w9wm) exec w9wm ;;
  jwm)  exec jwm ;;
  *) exec $DEFAULT_SESSION ;;
esac


