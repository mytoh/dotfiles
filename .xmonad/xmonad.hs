
import XMonad hiding ( (|||) )
import XMonad.ManageHook
import qualified XMonad.StackSet as W

import System.Exit

import Data.Monoid
import Data.Ratio
import qualified Data.Map        as M
import Graphics.X11.Xlib


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
import XMonad.Layout.DwmStyle
import XMonad.Layout.Roledex

import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Themes
import XMonad.Util.WorkspaceCompare
import XMonad.Util.NamedScratchpad

---------------------------------------------------
myTerminal    = "urxvtc "
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 1
myModMask       = mod1Mask

myIcons         = "/home/mytoh/.dzen/icons/"

myWorkspaces    =  
    [
      wrapBitmap "sm4tik/bug_01.xbm",
      wrapBitmap "sm4tik/fox.xbm",
      wrapBitmap "sm4tik/dish.xbm",
      wrapBitmap "sm4tik/cat.xbm",
      wrapBitmap "sm4tik/empty.xbm",
      wrapBitmap "sm4tik/shroom.xbm",
      wrapBitmap "sm4tik/bug_02.xbm",
      wrapBitmap "sm4tik/scorpio.xbm",
      wrapBitmap "sm4tik/ac.xbm"
     ] 
     where
        wrapBitmap bitmap = "^i(" ++ myIcons ++ bitmap ++ ")"

myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#1177ff"
myXftFont = "xft: fixed-9"
myDzenFont = "-adobe-helvetica-medium-r-normal--11-*"

-- Layouts ------------------------------------------
myLayoutHook =  avoidStruts                $ 
                windowNavigation           $
                mkToggle (single NBFULL)   $ 
                mkToggle (single REFLECTX) $
                mkToggle (single REFLECTY) $
                (collectiveLayouts)

                 where

                   collectiveLayouts = full ||| twopane ||| tabbed ||| tile ||| onebig ||| mosaic ||| sprl ||| Roledex 

                   full    = named "*" (smartBorders (noBorders (dwmStyle shrinkText myTheme Full)))
                   tile    = named "+" (smartBorders (withBorder 1 (limitWindows 5 (ResizableTall 1 0.03 0.5 []))))
                   tabbed  = named "=" (smartBorders (noBorders (mastered 0.02 0.4 $ tabbedAlways shrinkText myTheme)))
                   twopane = named "-" (smartBorders (withBorder 1 (TwoPane 0.02 0.4)))
                   mosaic  = named "%" (smartBorders (withBorder 1 (MosaicAlt M.empty)))
                   sprl    = named "@" (smartBorders (withBorder 1 (limitWindows 5 (spiral gratio))))
                   onebig  = named "#" (smartBorders (withBorder 1 (limitWindows 5 (OneBig 0.75 0.75))))

                   gratio      = toRational goldenratio
                   goldenratio = 2/(1+sqrt(5)::Double);

-- tabbar theme config ----------------------------------------
myTheme = defaultTheme {
            --  activeTextColor     = "#909090",
            --  activeColor         = "#909090",
                fontName            = myXftFont,
                decoHeight          = 13
}

-- keybindings --------------------------------------------
myKeys = [
         ("M-s", shellPrompt myXPConfig),
         ("M-f", sendMessage $ Toggle NBFULL),
         ("M-x", sendMessage $ Toggle REFLECTX),
         ("M-y", sendMessage $ Toggle REFLECTY),
         ("M-n", moveTo Next (WSIs notSP)),
         ("M-p", moveTo Prev (WSIs notSP)),
         ("M-t", scratchFiler),
         ("M-q", spawn myRestart),
         ("M-S-p", unsafeSpawn "import -window root $HOME/xwd-$(date +%s)$$.png")
         ]
          where
             notSP = (return $ ("SP" /=) . W.tag) :: X (WindowSpace -> Bool)

             scratchFiler = namedScratchpadAction myScratchPads "thunar"

             myRestart = "for pid in `pgrep dzen2`; do kill -9 $pid; done && xmonad --recompile && xmonad --restart"

-- shell prompt config ---------------------------------------------
myXPConfig = defaultXPConfig {
              position          = Bottom,
              promptBorderWidth = 0,
              height            = 14,
              font              = myXftFont,
              bgColor           = "#2a2733",
              fgColor           = "#909090",
              bgHLight          = "#6b6382",
              fgHLight          = "#4a4459"
              }



-- manage hooks -------------------------------------------------------    
myManageHook = insertPosition End Newer <+> composeAll
    [ isFullscreen                                        --> (doF W.focusDown <+> doFullFloat),
      isDialog                                            --> doFloat,
      className  =? "MPlayer"                             --> doFloat,
      className  =? "Main.py"                             --> doFloat,
      className  =? "Gimp"                                --> doFloat,
      className  =? "DTA"                                 --> doFloat,
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

-- log hooks --------------------------------------------------------------      
myLogHook h =  dynamicLogWithPP $ dzenPP { 
                ppCurrent         = dzenColor "#303030" "#909090" . pad,
                ppHidden          = dzenColor "#909090" "" .pad,
                ppHiddenNoWindows = dzenColor "#606060" "" . pad,
                ppLayout          = dzenColor "#77a8bf" "" .
                                    (\x -> case x of
                                        "Full" -> wrapBitmap "sm4tik/full.xbm"
                                        "*"          -> wrapBitmap "rob/full.xbm"
                                        "+"          -> wrapBitmap "rob/tall.xbm"
                                        "ReflectX *" -> wrapBitmap "rob/full.xbm"
                                        "ReflectX +" -> wrapBitmap "rob/tall.xbm"
                                        "ReflectX =" -> "="
                                        "ReflectX -" -> "-"
                                        "ReflectX %" -> "%"
                                        "ReflectX @" -> "@"
                                        "ReflectX #" -> "#"
                                        "ReflectY *" -> wrapBitmap "rob/full.xbm"
                                        "ReflectY +" -> wrapBitmap "rob/tall.xbm" 
                                        "ReflectY =" -> "="
                                        "ReflectY -" -> "-"
                                        "ReflectY %" -> "%"
                                        "ReflectY @" -> "@"
                                        "ReflectY #" -> "#"
                                        "ReflectX ReflectY *" -> wrapBitmap "rob/full.xbm"
                                        "ReflectX ReflectY +" -> wrapBitmap "rob/tall.xbm" 
                                        "ReflectX ReflectY =" -> "="
                                        "ReflectX ReflectY -" -> "-"
                                        "ReflectX ReflectY %" -> "%"
                                        "ReflectX ReflectY @" -> "@"
                                        "ReflectX ReflectY #" -> "#"
                                        _     -> x
                                        ),

                ppUrgent          = wrap (dzenColor "#ff0000" "" "{") (dzenColor "#ff0000" "" "}") . pad,
                ppTitle           = wrap "^fg(#909090)[ " " ]^fg()" . shorten 100,
                ppVisible         = wrap "{" "}",
                ppWsSep           = "",
                ppSep             = "  |  ",
                ppSort            = fmap (namedScratchpadFilterOutWorkspace.) (ppSort dzenPP),
                ppOutput          = hPutStrLn h
                }
                where
                  wrapBitmap bitmap = "^i(" ++ myIcons ++ bitmap ++ ")"

-- dzen bars ----------------------------------------------------------------------
myLeftBar = "dzen2 -p -ta l  -x 0 -y 0 -w 400 -h 12 -e 'onexit=ungrabmouse' -fn " ++ myDzenFont  
myRightBar = "~/.dzen/bin/status| dzen2 -p -ta r -x 400 -y 0 -w 880 -h 12 -e 'onexit=ungrabmouse' -fn " ++ myDzenFont
-- myConkyBar  = "conky -c ~/.conkyrc | dzen2 -p -ta r -x 400 -y 0 -w 880 -h 12 -fn '-adobe-helvetica-medium-r-normal--11-*' -e 'onexit=ungrabmouse'"

myEventHook = ewmhDesktopsEventHook

myStartupHook = return ()

-- main config ---------------------------------------------------------------------
main = myConfig
myConfig = do
      d  <- spawnPipe myLeftBar
      spawn myRightBar
      xmonad $ ewmh $ withUrgencyHook dzenUrgencyHook $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook d,
        startupHook        = myStartupHook
    } `additionalKeysP` myKeys
