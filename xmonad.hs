
import XMonad
import XMonad.ManageHook

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers 
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.NoBorders
import XMonad.Layout.DecorationMadness

import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Themes

import Data.Monoid
import System.Exit
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal    = "urxvtc "
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 1
myModMask       = mod1Mask
myWorkspaces    =  ["a", "b", "c", "d", "e", "f", "g", "h", "i"] 
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#0066ff"

-- myKeys = \c -> mkKeymap c $
--                 [ ("M-p", spawn "exe=`dmenu_path | dmenu -l 7 -nb black -nf darkgrey -fn 'terminus-8' ` && eval \"exec $exe\"") ]

myLayout = avoidStruts $ smartBorders $ (tallTabbed shrinkText (theme smallClean) ||| Full)
     
myManageHook = composeAll
    [ isFullscreen                  --> (doF W.focusDown <+> doFullFloat),
      className =? "MPlayer"        --> doFloat,
      className =? "Gimp"           --> doFloat,
      className =? "Thunar"         --> doFloat,
      className =? "Main.py"        --> doFloat,
      resource  =? "desktop_window" --> doIgnore,
      resource  =? "kdesktop"       --> doIgnore 
      ] <+> manageDocks <+> manageHook defaultConfig 
      
myLogHook h = dynamicLogWithPP $ dzenPP { 
                ppCurrent         = dzenColor "#303030" "#909090" . pad,
                ppHidden          = dzenColor "#909090" "" .pad,
                ppHiddenNoWindows = dzenColor "#606060" "" . pad,
                ppLayout          = dzenColor "#909090" "" . pad,
                ppUrgent          = wrap (dzenColor "#ff0000" "" "{") (dzenColor "#ff0000" "" "}") . pad,
                ppTitle           = wrap "^fg(#909090)[ " " ]^fg()" . shorten 40,
                ppWsSep           = "",
                ppSep             = "  ",
                ppOutput          = hPutStrLn h
                }

myLeftBar = "dzen2 -p -ta l  -x 0 -y 0 -w 400 -h 12 -fn '-adobe-helvetica-medium-r-normal--11-*' -e 'onexit=ungrabmouse'"
myRightBar = "~/local/bin/dzen.sh" 
-- myConkyBar  = "conky -c ~/.conkyrc | dzen2 -p -ta r -x 400 -y 0 -w 880 -h 12 -fn '-adobe-helvetica-medium-r-normal--11-*' -e 'onexit=ungrabmouse'"

myEventHook = ewmhDesktopsEventHook

myStartupHook = return () 

main = myConfig
myConfig = do
      d <- spawnPipe myLeftBar
      spawn myRightBar
      xmonad $ ewmh $ withUrgencyHook NoUrgencyHook $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
--      keys               = myKeys,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook d,
        startupHook        = myStartupHook
    }
