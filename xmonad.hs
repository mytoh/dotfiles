
import XMonad hiding ( (|||) )
import XMonad.ManageHook

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Monoid
import System.Exit
import System.IO

import XMonad.Actions.CycleWS

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers 
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.NoBorders
import XMonad.Layout.DecorationMadness
import XMonad.Layout.LayoutCombinators

import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Themes
import XMonad.Util.Scratchpad
import XMonad.Util.WorkspaceCompare

myTerminal    = "urxvtc "
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 1
myModMask       = mod1Mask
myWorkspaces    =  ["a", "b", "c", "d", "e", "f", "g", "h", "i"] 
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#0066ff"

-- Layouts
myLayout = avoidStruts $ smartBorders $ (tallTabbed shrinkText (theme smallClean) ||| Full)

-- keybindings
myKeys = [
     ("M-p", shellPrompt myXPConfig),
     ("M-f", sendMessage $ JumpToLayout "Full"),
     ("M-<R>", moveTo Next (WSIs notSP)),
     ("M-<L>" , moveTo Prev (WSIs notSP)) 
     ]
     where
        notSP = (return $ ("SP" /=) . W.tag) :: X (WindowSpace -> Bool)

-- prompt configuration
myXPConfig = defaultXPConfig {
              position        = Bottom,
              promptBorderWidth = 0,
              height            = 14,
              font              = "--adobe-helvetica-medium-r-normal--11-*",
              bgColor           = "#2a2733",
              fgColor           = "#aa9dcf",
              bgHLight          = "#6b6382",
              fgHLight          = "#4a4459"
              }


     
myManageHook = composeAll
    [ isFullscreen                  --> (doF W.focusDown <+> doFullFloat),
      isDialog                      --> doCenterFloat,
      className =? "MPlayer"        --> doFloat,
      className =? "Main.py"        --> doFloat,
      className =? "Gimp"           --> doFloat,
      className =? "DTA"            --> doFloat,
      className =? "Firefox" <&&> resource /=? "Navigator"  --> doFloat,
      className =? "Thunar"         --> doCenterFloat,
      resource  =? "desktop_window" --> doIgnore
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
myRightBar = "~/.dzen/bin/dzen.sh" 
-- myConkyBar  = "conky -c ~/.conkyrc | dzen2 -p -ta r -x 400 -y 0 -w 880 -h 12 -fn '-adobe-helvetica-medium-r-normal--11-*' -e 'onexit=ungrabmouse'"

myEventHook = ewmhDesktopsEventHook

myStartupHook = return () 

main = myConfig
myConfig = do
      d <- spawnPipe myLeftBar
      spawn myRightBar
      xmonad $ ewmh $ withUrgencyHook dzenUrgencyHook $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook d,
        startupHook        = myStartupHook
    } `additionalKeysP` myKeys
