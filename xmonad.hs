
import XMonad hiding ( (|||) )
import XMonad.ManageHook

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Data.Monoid
import Data.Ratio

import System.Exit
import System.IO

import XMonad.Actions.CycleWS

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers 
import XMonad.Hooks.UrgencyHook hiding (Never)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.XPropManage
import XMonad.Hooks.SetWMName

import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Decoration
import XMonad.Layout.LayoutHints
import XMonad.Layout.ResizableTile
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.OneBig
import XMonad.Layout.TwoPane
import XMonad.Layout.MosaicAlt
import XMonad.Layout.Spiral
import XMonad.Layout.Master
import XMonad.Layout.LimitWindows
import XMonad.Layout.Reflect
import XMonad.Layout.Named
import XMonad.Layout.WindowNavigation



import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Themes
import XMonad.Util.WorkspaceCompare
import XMonad.Util.NamedScratchpad

myTerminal    = "urxvtc "
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 1
myModMask       = mod1Mask
myWorkspaces    =  ["a", "b", "c", "d", "e", "f", "g", "h", "i"] 
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#0066ff"
myXftFont = "xft: fixed-9"
myDzenFont = "-adobe-helvetica-medium-r-normal--11-*"

-- Layouts
myLayout =  avoidStruts $ 
            windowNavigation $
            mkToggle (single NBFULL) $ 
            mkToggle (single REFLECTX) $
            mkToggle (single REFLECTY) $
            (collectiveLayouts)

              where
                collectiveLayouts = myFull ||| myTwoP ||| myTabD ||| myTile ||| myOneB ||| myMosC ||| mySprL

                myFull = named "*" (smartBorders (noBorders Full))
                myTile = named "+" (smartBorders (withBorder 1 (limitWindows 5 (ResizableTall 1 0.03 0.5 []))))
                myTabD = named "=" (smartBorders (noBorders (mastered 0.02 0.4 $ tabbedAlways shrinkText myTheme)))
                myTwoP = named "-" (smartBorders (withBorder 1 (TwoPane 0.02 0.4)))
                myMosC = named "%" (smartBorders (withBorder 1 (MosaicAlt M.empty)))
                mySprL = named "@" (smartBorders (withBorder 1 (limitWindows 5 (spiral gRatio))))
                myOneB = named "#" (smartBorders (withBorder 1 (limitWindows 5 (OneBig 0.75 0.75))))

                gRatio =toRational goldenRatio
                goldenRatio = 2/(1+sqrt(5)::Double);

-- theme config
myTheme = defaultTheme {
            --  activeTextColor     = "#909090",
            --  activeColor         = "#909090",
                fontName            = myXftFont,
                decoHeight          = 13
}

-- keybindings
myKeys = [
     ("M-s", shellPrompt myXPConfig),
  -- ("M-f", sendMessage $ JumpToLayout "Full"),
     ("M-f", sendMessage $ Toggle NBFULL),
     ("M-n", moveTo Next (WSIs notSP)),
     ("M-p", moveTo Prev (WSIs notSP)),
     ("M-t", scratchFiler),
     ("M-q", spawn myRestart)
     ]
     where
        notSP = (return $ ("SP" /=) . W.tag) :: X (WindowSpace -> Bool)

        scratchFiler = namedScratchpadAction myScratchPads "thunar"


myRestart = "for pid in `pgrep dzen2`; do kill -9 $pid; done && xmonad --recompile && xmonad --restart"

-- prompt config
myXPConfig = defaultXPConfig {
              position        = Bottom,
              promptBorderWidth = 0,
              height            = 14,
              font              = myXftFont,
              bgColor           = "#2a2733",
              fgColor           = "#909090",
              bgHLight          = "#6b6382",
              fgHLight          = "#4a4459"
              }



-- manage hooks     
myManageHook = insertPosition End Newer <+> composeAll
    [ isFullscreen                  --> (doF W.focusDown <+> doFullFloat),
      isDialog                      --> doFloat,
      className =? "MPlayer" --> doFloat,
      className =? "Main.py" --> doFloat,
      className =? "Gimp"    --> doFloat,
      className =? "DTA"     --> doFloat,
      (className =? "Firefox" <&&> resource =? "Dialog")  --> doFloat
      ] 
        <+> manageDocks 
        <+> manageHook defaultConfig 
        <+> namedScratchpadManageHook myScratchPads

myScratchPads = [ NS "thunar" spawnFiler findFiler manageFiler
                ]
    where
      spawnFiler  = "thunar"
      findFiler   = className =? "Thunar"
      manageFiler = customFloating $ W.RationalRect l t w h
        where
            h = 0.6
            w = 0.6
            t = (1 - h)/2
            l = (1 - w)/2

      
myLogHook h =  dynamicLogWithPP $ dzenPP { 
                ppCurrent         = dzenColor "#303030" "#909090" . pad,
                ppHidden          = dzenColor "#909090" "" .pad,
                ppHiddenNoWindows = dzenColor "#606060" "" . pad,
                ppLayout          = dzenColor "#77a8bf" "" .
                                    (\x -> case x of
                                        "Full" -> "*"
                                        "ReflectX *" -> "*"
                                        "ReflectX +" -> "+"
                                        "ReflectX =" -> "="
                                        "ReflectX -" -> "-"
                                        "ReflectX %" -> "%"
                                        "ReflectX @" -> "@"
                                        "ReflectY *" -> "*"
                                        "ReflectY +" -> "+"
                                        "ReflectY =" -> "="
                                        "ReflectY -" -> "-"
                                        "ReflectY %" -> "%"
                                        "ReflectY @" -> "@"
                                        "ReflectX ReflectY *" -> "*"
                                        "ReflectX ReflectY +" -> "+"
                                        "ReflectX ReflectY =" -> "="
                                        "ReflectX ReflectY -" -> "-"
                                        "ReflectX ReflectY %" -> "%"
                                        "ReflectX ReflectY @" -> "@"
                                        _     -> x
                                        ),

                ppUrgent          = wrap (dzenColor "#ff0000" "" "{") (dzenColor "#ff0000" "" "}") . pad,
                ppTitle           = wrap "^fg(#909090)[ " " ]^fg()" . shorten 30,
                ppVisible         = wrap "{" "}",
                ppWsSep           = "",
                ppSep             = "  |  ",
                ppSort            = fmap (namedScratchpadFilterOutWorkspace.) (ppSort dzenPP),
                ppOutput          = hPutStrLn h
                }

myLeftBar = "dzen2 -p -ta l  -x 0 -y 0 -w 400 -h 12 -e 'onexit=ungrabmouse' -fn " ++ myDzenFont  
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
