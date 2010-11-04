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
parcellite &
gnome-keyring-daemon -d &
mail-notification &
# tint2 & 
(sleep 1s && trayer --expand false --alpha 255  --tint 0xffffff --transparent false --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 9 --widthtype pixel --width 80 ) &
exec xmonad




