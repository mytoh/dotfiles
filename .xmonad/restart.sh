#!/bin/sh

for pid in `pgrep dzen2`; do kill -9 $pid; done; killall trayer; killall gmail-notifier; xmonad --recompile && xmonad --restart
