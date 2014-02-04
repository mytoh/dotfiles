module Mytoh.Config.App where
  import Mytoh.Config
  import XMonad

  myTerminal :: String
  myTerminal = "mlterm"

  -- dzen bars {{{
  myLeftBar   :: String
  myLeftBar   = "dzen2 -p -ta l  -x 0 -y 0 -w 420 -h 11 -bg \"#212122\" -fn " ++ myDzenFont
  myRightBar    :: String
  myRightBar  = "~/.xmonad/bin/status | exec dzen2 -p -ta r -x 420 -y 0 -w 710 -h 11 -bg \"#212122\" -fn " ++ myDzenFont
  -- }}}
  trayer      :: String
  trayer      = "exec trayer --expand true --alpha 10  --tint 0x232324 --transparent true --padding 0 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 11 --widthtype pixel --width 150 "
  -- stalonetray = "exec stalonetray -i 1 --dockapp-mode simple --icon-gravity W --grow-gravity E --geometry 8x1-0+0 --max-geometry 40x13 -bg '#333333' --sticky --skip-taskbar"
  mail        :: String
  mail        = "gmail-notifier"
  compmgr     :: String
  compmgr     = "xcompmgr -c -C -I1 -O1 -Ff"

  volumemgr   :: String
  volumemgr   = "gnome-volume-control-applet"
  uimPanel    = "uim-toolbar-gtk-systray"
  -- myConkyBar  = "conky -c ~/.conkyrc | dzen2 -p -ta r -x 400 -y 0 -w 880 -h 12 -fn '-adobe-helvetica-medium-r-normal--11-*' -e 'onexit=ungrabmouse'"
