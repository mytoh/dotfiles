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
xsetroot -cursor_name left_ptr -solid black &
nitrogen --restore &
urxvtcd -e screen -U -D -RR  -s /bin/tcsh -m &
#urxvtc -e screenie -s /bin/tcsh -m &
xscreensaver -no-splash &
parcellite &
#xsnow &
#oneko -sakura &
#xfce4-panel &
# tint2 & 
#exec xmonad
exec stumpwm

