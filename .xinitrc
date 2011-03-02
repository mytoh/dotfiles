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
xscreensaver -no-splash &
parcellite &
xcompmgr -n &   
#xfce4-panel &
#xsnow &
#oneko -sakura &
# tint2 & 
#exec xmonad
if [ "$1" = "twm" -o "$*" = "" ]; then
/home/mytoh/.dzen/bin/status | dzen2 -p -ta l -w 1160 -h 16 -bg gray15 -fn '-adobe-helvetica-medium-r-normal--10-*' -e 'onexit=ungrabmouse' &
trayer --expand false --alpha 20  --tint 0x606060 --transparent true --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 7 --widthtype pixel --width 120 &
sleep 10 && wbar -above-desk -bpress -isize 45 -balfa 20 -nanim 9 &
fi

DEFAULT_SESSION="twm"
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
  *)
        exec $DEFAULT_SESSION
        ;;
esac


