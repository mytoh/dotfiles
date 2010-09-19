
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
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

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#0066ff"


myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    ]


myLayout = avoidStruts $  tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100


myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat,
      className =? "Gimp"           --> doFloat,
      resource  =? "desktop_window" --> doIgnore,
      resource  =? "kdesktop"       --> doIgnore 
    ] <+> manageDocks <+> manageHook defaultConfig 

myLogHook h = dynamicLogWithPP $ defaultPP { 
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

myStatusBar = "dzen2 -p -ta l  -x 0 -y 0 -w 500 -h 15 -fg '#606060' -bg '#303030' -e 'onexit=ungrabmouse'"
myOtherBar  = "conky -c ~/.conkyrc | dzen2 -p -ta r -x 500 -y 0 -w 780 -h 15 -fg '#606060' -bg '#303030' -e 'onexit=ungrabmouse'"

myEventHook = mempty

myStartupHook = return ()


main = do 
      d <- spawnPipe myStatusBar
      spawn myOtherBar
      xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

     -- keys               = myKeys,
        mouseBindings      = myMouseBindings,

        layoutHook         = myLayout,
        manageHook         = manageDocks ,
        handleEventHook    = myEventHook,
        logHook            = myLogHook d,
        startupHook        = myStartupHook
    }
