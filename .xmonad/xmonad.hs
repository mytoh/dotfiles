
-- imports {{{
import XMonad hiding ( (|||) )
import System.Exit
import System.IO
import Data.Monoid
import Data.Ratio ((%))
import Data.List
import qualified Data.Map        as M
import Graphics.X11.Xlib
import Control.Monad (liftM2)      -- viewShift

import XMonad.ManageHook
import qualified XMonad.StackSet as W

-- <actions>
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.Search
import XMonad.Actions.Promote
import qualified XMonad.Actions.ConstrainedResize as SQR
import qualified XMonad.Actions.FlexibleResize    as FlexR
import XMonad.Actions.CopyWindow
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.RotSlaves
import XMonad.Actions.UpdatePointer
import XMonad.Actions.SinkAll
import XMonad.Actions.FloatKeys

-- <hooks>
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook hiding (Never)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.XPropManage
import XMonad.Hooks.SetWMName
import XMonad.Hooks.Script

-- <layout>
import XMonad.Layout hiding ( (|||) )
import qualified XMonad.Layout.Magnifier as Mag
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Decoration
import XMonad.Layout.DwmStyle
import XMonad.Layout.Roledex
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spiral
import XMonad.Layout.MosaicAlt
import XMonad.Layout.OneBig
import XMonad.Layout.TwoPane
import XMonad.Layout.Reflect

-- <layout helpers>
import XMonad.Layout.Master
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.LimitWindows
import XMonad.Layout.Named
import XMonad.Layout.WindowNavigation
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LayoutHints
import XMonad.Layout.LayoutModifier
import XMonad.Layout.PerWorkspace (onWorkspace)

-- <prompt>
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Input
import XMonad.Prompt.Window
import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt.Layout

-- <util>
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Themes
import XMonad.Util.Scratchpad
import XMonad.Util.Font
import XMonad.Util.XSelection
import XMonad.Util.WorkspaceCompare
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.WindowProperties
import XMonad.Util.NamedScratchpad

-- }}}

myTerminal       = "urxvtcd "
myBorderWidth    = 2
myModMask        = mod1Mask
myIconsDirectory = "/home/mytoh/.dzen/icons/"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myWorkspaces    =
    [
     "yksi"
    , "kaksi"
    , "kolme"
    , "neljä"
 -- , wrapBitmap "sm4tik/bug_01.xbm"
 -- , wrapBitmap "sm4tik/fox.xbm"
 -- , wrapBitmap "sm4tik/dish.xbm"
 -- , wrapBitmap "sm4tik/cat.xbm"
 -- , wrapBitmap "sm4tik/empty.xbm"
 -- , wrapBitmap "sm4tik/bug_02.xbm"
 -- , wrapBitmap "sm4tik/shroom.xbm"
 -- , wrapBitmap "sm4tik/scorpio.xbm"
 -- , wrapBitmap "sm4tik/ac.xbm"
     ]
     where
        wrapBitmap bitmap = "^i(" ++ myIconsDirectory ++ bitmap ++ ")"

-- colors {{{
myNormalBorderColor  = "#111111"
myFocusedBorderColor = "#ad9dc5"
-- }}}

-- Fonts -------------------------------------------
myTabFont  = "-*-terminus-medium-r-normal-*-12-*-*-*-*-*-iso10646-*"
myXPFont   = "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1"
-- myDzenFont = "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1"
myDzenFont = "-nil-profont-medium-r-normal--10-100-72-72-c-50-iso8859-1"

-- Layouts ------------------------------------------
myLayoutHook =  avoidStruts                $
                windowNavigation           $
                mkToggle (single NBFULL)   $
                mkToggle (single REFLECTX) $
                mkToggle (single REFLECTY) $
                onWorkspace "kolme" full   $
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
                activeTextColor     = "#909090"
              , activeColor         = "#303030"
              , fontName            = myTabFont
              , decoHeight          = 13
}

-- keybindings --------------------------------------------
myKeys = [ -- M4 for Super key
         ("Tab",   windows W.focusDown)

       , ("M-p r", spawn ("dmenu_run -b -fn " ++ myDzenFont)) -- dzen prompt
    -- , ("M-p r", shellPrompt myXPConfig) -- shell prompt
       , ("M-p t", prompt (myTerminal ++ " -e") myXPConfig) -- run in term
       , ("M-p g", windowPromptGoto myWaitSP ) -- window go prompt
       , ("M-p b", windowPromptBring myWaitSP ) -- window bring prompt
       , ("M-p d", AL.launchApp myXPConfig { defaultText = "~" } "dolphin" ) -- filer prompt
       , ("M-p f", scratchFiler)

       , ("M-f", sendMessage $ Toggle NBFULL)
       , ("M-x", sendMessage $ Toggle REFLECTX)
       , ("M-y", sendMessage $ Toggle REFLECTY)

    -- , ("M-n", moveTo Next (WSIs notSP))
       , ("M-b", withFocused $ windows . W.sink)
       , ("M-q", spawn myRestart)
       , ("M-S-p", unsafeSpawn "scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/local/tmp/'")
         ]
          where
             notSP = (return $ ("SP" /=) . W.tag) :: X (WindowSpace -> Bool)

             scratchFiler = namedScratchpadAction myScratchPads "dolphin"

             myRestart = "for pid in `pgrep trayer`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep dzen2`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep gmail-notifier`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep compton`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep parcellite`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep uim-toolbar-gtk-systray`; do kill -9 $pid; done ;" ++
                         "xmonad --restart"


-- shell prompt config ---------------------------------------------
myXPConfig = defaultXPConfig {
              position          = Bottom
            , promptBorderWidth = 0
            , height            = 15
            , font              = myXPFont
            , bgColor           = "#2a2733"
            , fgColor           = "#909090"
            , bgHLight          = "#6b6382"
            , fgHLight          = "#4a4459"
            , defaultText       = ""
              }

myWaitSP = myXPConfig { autoComplete   = Just 1000000 }



-- manage hooks -------------------------------------------------------
myManageHook = -- insertPosition End Newer <+> composeAll
       (composeAll . concat $
        -- [ [isFullscreen                                        --> (doF W.focusDown <+> doFullFloat) ]
        [ [isFullscreen                                        --> doFullFloat ]
        , [isDialog                                            --> doFloat]
        , [className  =? "feh"                                 --> viewShift "kolme"]
        , [className  =? c                                     --> doFloat | c <- myFloats ]
        , [className  =? "MPlayer"                             --> (doFullFloat <+> viewShift "kolme")]
        , [className =? "V2C"                                  -->  viewShift "kaksi"]
        , [className =? "Firefox"                              -->  viewShift "kaksi"]
        , [(className =? "Firefox" <&&> resource =? "Dialog")  --> (doFloat <+> viewShift "kaksi")]
        ])
         <+> namedScratchpadManageHook myScratchPads
         <+> manageDocks
         <+> manageHook defaultConfig

       where
         viewShift = doF . liftM2 (.) W.greedyView W.shift
         myFloats = ["Main.py","Gimp","DTA","Gcolor2","Switch2","Uim-pref-gtk"]

myScratchPads = [ NS "dolphin" spawnFiler findFiler manageFiler
                ]
                   where
                     spawnFiler  = "dolphin"
                     findFiler   = className =? "Dolphin"
                     manageFiler = customFloating $ W.RationalRect l t w h
                       where
                           h = 0.6
                           w = 0.6
                           t = (1 - h)/2
                           l = (1 - w)/2

-- log hooks --------------------------------------------------------------
myLogHook h =  dynamicLogWithPP $ dzenPP {
                ppCurrent         = dzenColor "#8fae9f" "" . pad
              , ppHidden          = dzenColor "#909090" "" . pad
              , ppHiddenNoWindows = dzenColor "#606060" "" . pad
              , ppLayout          = dzenColor "#77a8bf" "" .
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
                                        )

              , ppUrgent          = wrap (dzenColor "#ff0000" "" "{") (dzenColor "#ff0000" "" "}") . pad
            --, ppTitle           = wrap "^fg(#909090)[ " " ]^fg()" . shorten 100
              , ppTitle           = wrap "^fg(#909090)( " " )^fg()" 
              , ppVisible         = wrap "{" "}"
              , ppWsSep           = ""
              , ppSep             = " | "
              , ppSort            = fmap (namedScratchpadFilterOutWorkspace.) (ppSort dzenPP)
              , ppOutput          = hPutStrLn h
                }
                where
                  wrapBitmap bitmap = "^i(" ++ myIconsDirectory ++ bitmap ++ ")"


myEventHook = ewmhDesktopsEventHook

-- dzen bars {{{
myLeftBar   = "dzen2 -p -ta l  -x 0 -y 0 -w 420 -h 15 -bg \"#212122\" -fn " ++ myDzenFont
myRightBar  = "~/.dzen/bin/status.scm | exec dzen2 -p -ta r -x 420 -y 0 -w 710 -h 15 -bg \"#212122\" -fn " ++ myDzenFont 
-- }}}
trayer      = "exec trayer --expand true --alpha 40  --tint 0x232324 --transparent true --padding 0 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 15 --widthtype pixel --width 150 "
mail        = "gmail-notifier"
compmgr     = "xcompmgr -I1 -O1 -Ff"
bgmgr       = "feh --bg-scale ~/.wallpapers/purple-nagato.jpg"
clipmgr     = "parcellite"
volumemgr   = "gnome-volume-control-applet"
uimPanel         = "uim-toolbar-gtk-systray"
-- myConkyBar  = "conky -c ~/.conkyrc | dzen2 -p -ta r -x 400 -y 0 -w 880 -h 12 -fn '-adobe-helvetica-medium-r-normal--11-*' -e 'onexit=ungrabmouse'"

myStartupHook :: X ()
myStartupHook = do
                spawn myRightBar
                spawn trayer
                spawn mail
                spawn bgmgr
                spawn clipmgr
                spawn volumemgr
                -- spawn compmgr
                {- spawn uimPanel -}
                execScriptHook "startup"

-- main config ---------------------------------------------------------------------
main = myConfig
myConfig = do
      d  <- spawnPipe myLeftBar
      xmonad $ ewmh $ withUrgencyHook NoUrgencyHook $ defaultConfig {
          terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , layoutHook         = myLayoutHook
        , manageHook         = myManageHook
        , handleEventHook    = myEventHook
        , logHook            = myLogHook d >> setWMName "LG3D"
        , startupHook        = myStartupHook
    } `additionalKeysP` myKeys




-- vim: fenc=utf-8
