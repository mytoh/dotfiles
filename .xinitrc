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
feh --bg-scale ~/local/var/pic/back.jpg &
urxvtd -q -o -f 
urxvtc -e screen -U -D -RR  -s /bin/tcsh -m &
xscrennsaver -no-splash &
#tint2 & 
exec xmonad




