#!/bin/sh
mozc_server_start
#pulseaudio -D &
export XIM="ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="-r --daemonize --xim"
ibus-daemon -d -x &
#vnstatd -d  &
xrdb -merge .Xresources
xsetroot -cursor_name left_ptr -solid black &
xmodmap .Xmodmap
feh --bg-scale ~/local/var/pic/eilanya.png &
urxvtd -q -o -f 
urxvtc -e screen -U -D -RR  -s /bin/tcsh -m &
xscrennsaver -no-splash &
#while true; do date; dmesg | tail -n 10; sleep 10; done | dzen2 -l 10 -u -e '' -x 200 -w 1280 -ta r  -p &
tint2 &
trayer --edge bottom --align right --SetDockType true --SetPartialStrut true --expand true --width 15 --height 12 --transparent true --tint 0x000000 &
exec /usr/local/bin/xmonad

