#!/bin/sh

# ibus {{{
# export XIM=ibus
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=xim
# export XMODIFIERS=@im=ibus
# export XIM_PROGRAM="ibus-daemon"
# export XIM_ARGS=" --daemonize --xim"
# sleep 1
# }}}

# uim {{{
export GTK_IM_MODULE="uim"
export QT_IM_MODULE="uim"
export XMODIFIERS=@im=uim
# export UIM_CANDWIN_PROG=uim-candwin-gtk
uim-xim &
uim-toolbar-gtk-systray &
#}}}

# kde
# export XDG_DATA_DIRS="/usr/local/kde4/share:/usr/local/share/:$XDG_DATA_DIRS"
export QT_PLUGIN_PATH="/usr/local/kde4/lib/kde4/plugins"

export PATH="$HOME/local/bin:$PATH"
export VTE_CJK_WIDTH=1
xrdb -merge $HOME/.Xresources
setxkbmap dvorak
xmodmap $HOME/.xmodmaprc
xset b off # turn off beep
xset r rate 200 40
xsetroot -cursor_name right_ptr
xset +fp /usr/local/lib/X11/fonts/local
xset +fp /usr/local/lib/X11/fonts/TrueType
xset +fp /usr/local/lib/X11/fonts/cyrillic
xset +fp /usr/local/lib/X11/fonts/profont
xset +fp /usr/local/lib/X11/fonts/terminus-font
xset +fp /usr/local/lib/X11/fonts/bitstream-vera
xset +fp /usr/local/lib/X11/fonts/dejavu
xset +fp /usr/local/lib/X11/fonts/Droid
xset +fp /usr/local/lib/X11/fonts/artwiz-aleczapka-en
xset +fp /usr/local/lib/X11/fonts/code2001
xset +fp /usr/local/lib/X11/fonts/jmk
xset +fp $HOME/.fonts
xset +fp $HOME/.fonts/jmk
xset fp rehash
urxvtcd &
xbindkeys &
Thunar --daemon &
spiffy &
#parcellite &
gosh -I~/.site ~/.site/makiki-server.scm &
synergys --name $(hostname -s)
mpd
sudo /etc/netstart

if [ "$1" = "twm"  -o "$1" = "flwm" ]; then
  $HOME/.dzen/bin/status | dzen2 -p -ta l -w 1160 -h 13 -bg gray15 -fn '-*-terminus-medium-r-normal--12-*' -e 'onexit=ungrabmouse' &
  trayer --expand false --alpha 20  --tint 0x606060 --transparent true --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 7 --widthtype pixel --width 120 &
  #sleep 20 && wbar -above-desk -bpress -isize 45 -balfa 20 -nanim 9 &
  if [ -f $HOME/.fehbg ]; then
    $HOME/.fehbg &
  else
    feh --bg-max ~/.wallpaper &
  fi
  tint2 &
fi

DEFAULT_SESSION="dwm"
if [ -n $1 ]; then
  export USERWM=$1
 case $1 in
  xfce) exec dbus-launch ck-launch-session startxfce4 ;;
  fluxbox) exec startfluxbox ;;
  fvwm|fvwm2) exec fvwm2 ;;
  fvwm-themes*) exec fvwm-themes-start -s sa ;;
  dwm) exec $HOME/.dwm/startdwm ;;
  kde) exec startkde4 ;;
  gnome) exec gnome-session ;;
  mate) exec ck-launch-session mate-session ;;
  rox) exec rox -S ;;
lainwm) exec lainwm ;;
  *) exec dbus-launch --exit-with-session ck-launch-session $1 ;;
 esac
else
  exec $DEFAULT_SESSION
fi
