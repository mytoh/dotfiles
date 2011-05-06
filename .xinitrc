#!/bin/sh
export XIM="ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS=@im=ibus
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="-r --daemonize --xim"
ibus-daemon -d -x &
xrdb -merge .Xresources
xmodmap .Xmodmap
setxkbmap dvorak
xsetroot -cursor_name right_ptr &
nitrogen --restore &
#hsetroot -fill ~/wallpaper.jpg
#xcompmgr -c&
urxvtcd -e screen -U -D -RR  -s /bin/tcsh -m &
parcellite &
xbindkeys &
Thunar --daemon &
mpd 

if [ "$1" = "twm" -o "$1" = "openbox" ]; then
/home/mytoh/.dzen/bin/status | dzen2 -p -ta l -w 1160 -h 16 -bg gray15 -fn '-adobe-helvetica-medium-r-normal--10-*' -e 'onexit=ungrabmouse' &
trayer --expand false --alpha 20  --tint 0x606060 --transparent true --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 7 --widthtype pixel --width 120 &
#sleep 20 && wbar -above-desk -bpress -isize 45 -balfa 20 -nanim 9 &
fbpanel &
fi



DEFAULT_SESSION="xmonad"
case $1 in
  stumpwm) exec stumpwm ;;
  sawfish) exec sawfish ;;
  xmonad) exec xmonad ;;
  twm) exec twm -v ;;
  xfce) exec startxfce4 ;;
  fluxbox) exec fluxbox ;;
  pekwm) exec pekwm ;;
  flwm) exec flwm ;;
  evilwm) exec evilwm ;;
  qvwm) exec qvwm ;;
  fvwm*) exec fvwm;;
  dwm) exec dwm ;;
  swm) exec swm ;;
  awesome) exec awesome ;;
  *) exec $DEFAULT_SESSION ;;
esac


