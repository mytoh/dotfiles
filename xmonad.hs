
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
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

myLayout = tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio

     nmaster = 1

     ratio   = 1/2

     delta   = 3/100


myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]


myEventHook = mempty

myStartupHook = return ()


main = do 
      xmproc <- spawnPipe "xmobar"
      xmonad $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

     -- keys               = myKeys,
        mouseBindings      = myMouseBindings,

        layoutHook         = avoidStruts $ myLayout ,
        manageHook         = manageDocks <+> myManageHook <+> manageHook defaultConfig,
        handleEventHook    = myEventHook,
        logHook            = dynamicLogWithPP $ xmobarPP
                                 { ppOutput = hPutStrLn xmproc,
                                   ppTitle = xmobarColor "green" "" . shorten 50
                                 },
        startupHook        = myStartupHook
    }
