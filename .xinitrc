#!/bin/sh
mozc_server_start
export XIM="ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="-r --daemonize --xim"
ibus-daemon -d -x &
xrdb -merge .Xresources
xsetroot -cursor_name left_ptr -solid black &
xmodmap .Xmodmap
feh --bg-scale ~/local/var/pic/eilanya.png &
urxvtd -q -o -f 
urxvtc -e screen -U -D -RR  -s /bin/tcsh -m &
xscrennsaver -no-splash &
#tint2 &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 16 --height 14 --transparent true --tint 0x000000 &
exec /usr/local/bin/xmonad

