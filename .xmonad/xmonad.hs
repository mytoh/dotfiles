
import XMonad hiding ( (|||) )
import XMonad.ManageHook
import qualified XMonad.StackSet as W

import System.Exit

import Data.Monoid
import Data.Ratio
import qualified Data.Map        as M
import Graphics.X11.Xlib
import Control.Monad (liftM2)      -- viewShift

import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo (runOrRaise)

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
import XMonad.Prompt.RunOrRaise

import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Themes
import XMonad.Util.WorkspaceCompare
import XMonad.Util.NamedScratchpad

---------------------------------------------------
myTerminal    = "urxvtcd "
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
myBorderWidth   = 2
myModMask       = mod1Mask
myIcons         = "/home/mytoh/.dzen/icons/"

myWorkspaces    =
    [
     "term",
     "web",
     "media"
      -- wrapBitmap "sm4tik/bug_01.xbm",
      -- wrapBitmap "sm4tik/fox.xbm",
      -- wrapBitmap "sm4tik/dish.xbm",
      -- wrapBitmap "sm4tik/cat.xbm",
      -- wrapBitmap "sm4tik/empty.xbm",
      -- wrapBitmap "sm4tik/bug_02.xbm",
      -- wrapBitmap "sm4tik/shroom.xbm",
      -- wrapBitmap "sm4tik/scorpio.xbm",
      -- wrapBitmap "sm4tik/ac.xbm"
     ]
     where
        wrapBitmap bitmap = "^i(" ++ myIcons ++ bitmap ++ ")"

-- Colors ------------------------------------------
myNormalBorderColor  = "#111111"
--myFocusedBorderColor = "#ad9dc5"
myFocusedBorderColor = "#cfa9a5"

-- Fonts -------------------------------------------
myTabFont = "-*-terminus-medium-r-normal-*-12-*-*-*-*-*-iso10646-*"
myXPFont = "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1"
myDzenFont = "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1"

-- Layouts ------------------------------------------
myLayoutHook =  avoidStruts                $
                windowNavigation           $
                mkToggle (single NBFULL)   $
                mkToggle (single REFLECTX) $
                mkToggle (single REFLECTY) $
                (collectiveLayouts)

                 where

--                 collectiveLayouts = tabbed ||| twopane ||| full ||| tile ||| onebig ||| mosaic ||| sprl ||| Roledex
                   collectiveLayouts = twopane ||| full ||| tile ||| onebig ||| mosaic ||| sprl ||| Roledex

                   full    = named "*" (smartBorders (noBorders (dwmStyle shrinkText myTheme Full)))
                   tile    = named "+" (smartBorders (withBorder 1 (limitWindows 5 (ResizableTall 1 0.03 0.5 []))))
                   tabbed  = named "=" (smartBorders (noBorders (mastered 0.02 0.4 $ tabbedBottomAlways shrinkText myTheme)))
                   twopane = named "-" (smartBorders (withBorder 1 (TwoPane 0.02 0.4)))
                   mosaic  = named "%" (smartBorders (withBorder 1 (MosaicAlt M.empty)))
                   sprl    = named "@" (smartBorders (withBorder 1 (limitWindows 5 (spiral gratio))))
                   onebig  = named "#" (smartBorders (withBorder 1 (limitWindows 5 (OneBig 0.75 0.75))))

                   gratio      = toRational goldenratio
                   goldenratio = 2/(1+sqrt(5)::Double);

-- tabbar theme config ----------------------------------------
myTheme = defaultTheme {
                activeTextColor     = "#909090",
                activeColor         = "#303030",
                fontName            = myTabFont,
                decoHeight          = 13
}

-- keybindings --------------------------------------------
myKeys = [ -- M4 for Super key
         ("M-p", shellPrompt myXPConfig),
         ("M-f", sendMessage $ Toggle NBFULL),
         ("M-x", sendMessage $ Toggle REFLECTX),
         ("M-y", sendMessage $ Toggle REFLECTY),
         -- ("M-n", moveTo Next (WSIs notSP)),
         ("M-b", withFocused $ windows . W.sink),
         ("M-q", spawn myRestart),
         ("M-S-p", unsafeSpawn "scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/local/tmp/'")
         ]
          where
             notSP = (return $ ("SP" /=) . W.tag) :: X (WindowSpace -> Bool)

             scratchFiler = namedScratchpadAction myScratchPads "thunar"

             myRestart = "for pid in `pgrep trayer`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep dzen2`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep gmail-notifier`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep compton`; do kill -9 $pid; done ;" ++
                         "xmonad --recompile && xmonad --restart"


-- shell prompt config ---------------------------------------------
myXPConfig = defaultXPConfig {
              position          = Bottom,
              promptBorderWidth = 0,
              height            = 20,
              font              = myXPFont,
              bgColor           = "#2a2733",
              fgColor           = "#909090",
              bgHLight          = "#6b6382",
              fgHLight          = "#4a4459"
              }



-- manage hooks -------------------------------------------------------
myManageHook = -- insertPosition End Newer <+> composeAll
       (composeAll . concat $
        [ [isFullscreen                                        --> (doF W.focusDown <+> doFullFloat) ]
        , [isDialog                                            --> doFloat]
        , [className  =? "feh"                                 --> doCenterFloat]
        , [className  =? c                                     --> doFloat | c <- myFloats ]
        , [className  =? "MPlayer"                             --> (doFullFloat <+> viewShift "media")]
        , [className =? "Firefox"                             -->  viewShift "web"]
        , [(className =? "Firefox" <&&> resource =? "Dialog")  --> (doFloat <+> viewShift "web")]
        ])
         <+> namedScratchpadManageHook myScratchPads
         <+> manageDocks
         <+> manageHook defaultConfig
        
       where 
         viewShift = doF . liftM2 (.) W.greedyView W.shift
         myFloats = ["Main.py","Gimp","DTA","Gcolor2","Switch2"]

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
                ppCurrent         = dzenColor "#8fae9f" "" . pad,
                ppHidden          = dzenColor "#909090" "" .pad,
                ppHiddenNoWindows = dzenColor "#606060" "" . pad,
                ppLayout          =    dzenColor "#77a8bf" "" .
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
            --  ppTitle           = wrap "^fg(#909090)[ " " ]^fg()" . shorten 100,
                ppTitle           = wrap "^fg(#909090)( " " )^fg()" ,
                ppVisible         = wrap "{" "}",
                ppWsSep           = "",
                ppSep             = " | ",
                ppSort            = fmap (namedScratchpadFilterOutWorkspace.) (ppSort dzenPP),
                ppOutput          = hPutStrLn h
                }
                where
                  wrapBitmap bitmap = "^i(" ++ myIcons ++ bitmap ++ ")"


myEventHook = ewmhDesktopsEventHook

-- dzen bars ----------------------------------------------------------------------
myLeftBar   = "dzen2 -p -ta l  -x 0 -y 0 -w 450 -h 13 -fn " ++ myDzenFont
myRightBar  = "~/.dzen/bin/status | exec dzen2 -p -ta r -x 450 -y 0 -w 700 -h 13 -fn " ++ myDzenFont
trayer      = "exec trayer --expand true --alpha 100  --tint 0x303030 --transparent true --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 8 --widthtype request --width 100 "
mail        = "gmail-notifier"
compmgr     = "compton -i 0.9 -e 0.8"
bgmgr       = "feh --bg-scale ~/.wallpapers/purple-nagato.jpg"
clipmgr     = "parcellite"
volumemgr   = "gnome-volume-control-applet"
-- myConkyBar  = "conky -c ~/.conkyrc | dzen2 -p -ta r -x 400 -y 0 -w 880 -h 12 -fn '-adobe-helvetica-medium-r-normal--11-*' -e 'onexit=ungrabmouse'"

myStartupHook :: X ()
myStartupHook = do
                spawn myRightBar
                spawn trayer
                spawn mail
                spawn compmgr
                spawn bgmgr
                spawn clipmgr
                spawn volumemgr

-- main config ---------------------------------------------------------------------
main = myConfig
myConfig = do
      d  <- spawnPipe myLeftBar
      xmonad $ ewmh $ withUrgencyHook NoUrgencyHook $ defaultConfig {
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
        logHook            = myLogHook d >> setWMName "LG3D",
        startupHook        = myStartupHook
    } `additionalKeysP` myKeys

