#!/bin/csh

killall dzen2
killall trayer
killall gmail-notifier
xmonad --recompile 
xmonad --restart

# for pid in `pgrep dzen2`; do kill -9 $pid; done; killall trayer; killall gmail-notifier; xmonad --recompile && xmonad --restart
