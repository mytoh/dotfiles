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
xsetroot -cursor_name right_ptr -solid black &
nitrogen --restore &
urxvtcd -e screen -U -D -RR  -s /bin/tcsh -m &
#urxvtc -e screenie -s /bin/tcsh -m &
#xscreensaver -no-splash &
parcellite &
xcompmgr -a &   
xbindkeys &
thunar --daemon &
#xsnow &
#oneko -sakura &
# tint2 & 

if [ "$1" = "twm" -o "$1" = "openbox" ]; then
/home/mytoh/.dzen/bin/status | dzen2 -p -ta l -w 1160 -h 16 -bg gray15 -fn '-adobe-helvetica-medium-r-normal--10-*' -e 'onexit=ungrabmouse' &
trayer --expand false --alpha 20  --tint 0x606060 --transparent true --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 7 --widthtype pixel --width 120 &
#sleep 20 && wbar -above-desk -bpress -isize 45 -balfa 20 -nanim 9 &
fbpanel &
fi

DEFAULT_SESSION="qvwm"
case $1 in
  stumpwm)
        exec stumpwm
        ;;
  sawfish)
        exec sawfish
        ;;
  xmonad)
        exec xmonad
        ;;
  twm)
        exec twm -v
        ;;
  xfce)
        exec startxfce4
        ;;
  swm)
        exec swm
        ;;
  fluxbox)
        exec fluxbox
        ;;
  pekwm)
        exec pekwm
        ;;
  evilwm)
        exec evilwm
        ;;
  openbox)
        exec openbox
        ;;
  golem)
        exec golem
        ;;
  qvwm)
        exec qvwm
        ;;
  wmfs)
        exec wmfs
        ;;
  fvwm95)
	exec fvwm95
	;;
  *)
        exec $DEFAULT_SESSION
        ;;
esac


