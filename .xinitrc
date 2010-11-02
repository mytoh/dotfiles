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
urxvtd -q -o -f 
urxvtc -e screen -U -D -RR  -s /bin/tcsh -m &
xscrennsaver -no-splash &
vnstatd -ds &
#tint2 & 
(sleep 2s && trayer --expand true --alpha 255 --edge top --align right --SetDockType true --widthtype requet --pixel 80) &
exec xmonad




