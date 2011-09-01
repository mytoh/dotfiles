#!/bin/sh

mplayer='^ca(1,gmplayer)^i(/home/mytoh/.stumpwm/icons/play.xbm)^fg()^ca()'
xterm='^ca(1,xterm)^i(/home/mytoh/.stumpwm/icons/eye_l.xbm)^fg()^ca()'
xclock='^ca(1,xclock)^i(/home/mytoh/.stumpwm/icons/clock.xbm)^fg()^ca()'
launcher="${mplayer} ${xterm} ${xclock}"

echo $launcher  | dzen2 -p -x 1200 -h 14 -bg grey20 -expand -l
