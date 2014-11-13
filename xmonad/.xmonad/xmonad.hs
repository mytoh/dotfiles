{-# LANGUAGE ExistentialQuantification #-}

-- imports {{{
import XMonad hiding ( (|||) )
import System.Exit
import System.IO
import System.Directory
import Data.Monoid
import Data.Ratio ((%))
import Data.Char                    (isSpace)
import Data.List
import qualified Data.Map        as M
import Graphics.X11.Xlib
import Control.Monad (liftM2)      -- viewShift
import Control.Arrow                (first, (&&&), (***))

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
import XMonad.Actions.WindowBringer
import XMonad.Actions.GridSelect

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
import XMonad.Hooks.ICCCMFocus

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
import XMonad.Layout.Spacing  (spacing)


-- <layout helpers>
import XMonad.Layout.Master
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.LimitWindows
import XMonad.Layout.Named
import XMonad.Layout.Renamed
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

import Mytoh.Config
import Mytoh.Config.App

-- }}}



-- Layouts ------------------------------------------
myLayoutHook =  avoidStruts                $
                windowNavigation           $
                mkToggle (single NBFULL)   $
                mkToggle (single REFLECTX) $
                mkToggle (single REFLECTY) $
                onWorkspace "kolme" full   $
                collectiveLayouts

                  where

--                 collectiveLayouts = tabbed ||| twopane ||| full ||| tile ||| onebig ||| mosaic ||| sprl ||| Roledex
                   collectiveLayouts = full ||| twopane |||  tile ||| stile ||| onebig ||| mosaic ||| sprl ||| Roledex ||| tabbed ||| magnifiedtall

                   full          = renamed [Replace "*"] $ smartBorders $ withBorder 1 $ dwmStyle shrinkText myTheme Full
                   tile          = renamed [Replace "+"] $ smartBorders $ withBorder 1 $ limitWindows 5 $ ResizableTall 1 0.03 0.5 []
                   stile         = renamed [Replace "/+/"] $ smartBorders $ withBorder 1 $ limitWindows 5 $ spacing 3 $ ResizableTall 1 0.03 0.5 []
                   tabbed        = renamed [Replace "="] $ smartBorders $ noBorders $ mastered 0.02 0.4 $ tabbedBottomAlways shrinkText myTheme
                   twopane       = renamed [Replace "-"] $ smartBorders $ withBorder 1 $ TwoPane 0.02 0.4
                   mosaic        = renamed [Replace "%"] $ smartBorders $ withBorder 1 $ MosaicAlt M.empty
                   sprl          = renamed [Replace "@"] $ smartBorders $ withBorder 1 $ limitWindows 5 $ spiral gratio
                   onebig        = renamed [Replace "#"] $ smartBorders $ withBorder 1 $ limitWindows 5 $ OneBig 0.75 0.75
                   magnifiedtall = renamed [Replace "+|+"] $ smartBorders $ withBorder 1 $ Mag.magnifiercz' 1.6 (ResizableTall 1 0.03 0.5 [])

                   gratio      = toRational goldenratio
                   goldenratio = 2 / (1 + sqrt(5)::Double);


-- keybindings --------------------------------------------
myKeys = [ -- M4 for Super key
         ("Tab",   windows W.focusDown)

       -- , ("M-p r", spawn ("yeganesh -x -- -b -p \">\" -fn " ++ myDzenFont)) -- dzen prompt
       -- , ("M-p t", prompt (myTerminal ++ " -e") myXPConfig) -- run in term
       -- , ("M-p g", windowPromptGoto myWaitSP ) -- window go prompt
       -- , ("M-p b", windowPromptBring myWaitSP ) -- window bring prompt
       -- , ("M-p b", bringMenu ) -- window bring prompt wth dmenu
       -- , ("M-p g", gotoMenu ) -- window goto prompt wth dmenu
       , ("M-p f", scratchFiler)

       , ("M-f", sendMessage $ Toggle NBFULL)
       , ("M-x", sendMessage $ Toggle REFLECTX)
       , ("M-y", sendMessage $ Toggle REFLECTY)

    -- , ("M-n", moveTo Next (WSIs notSP))
       , ("M-b", withFocused $ windows . W.sink)
       , ("M-q", spawn myRestart)
       , ("M-S-p", unsafeSpawn "scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/local/tmp/'")
       , ((myappkey "e"), runOrRaise "emacs" $ className =? "Emacs")
       , ((myappkey "f"), runOrRaise myFilemgr $ resource =? myFilemgr)
       -- , ((myappkey "r"), spawn $ "dmenu_run -b -p \">\" -fn " ++ myDzenFont) -- dzen prompt
      , ((myappkey "r"), shellPrompt myXPConfig) -- shell prompt
       , ((myappkey "t"), spawn $ myTerminal)
       , ((myappkey "v"), runOrRaise "v2c" $ className =? "V2C")
       , ((myappkey "b"), runOrRaise myBrowser $ resource =? myBrowser)
        , ((myappkey "<Space>"), unsafeSpawn "kupfer")
        , ((mygskey "g"), goToSelected defaultGSConfig)
      , ((mygskey "s"), spawnSelected defaultGSConfig ["xterm","gmplayer","gvim"])
         ]
           where
             notSP = (return $ ("SP" /=) . W.tag) :: X (WindowSpace -> Bool)

             scratchFiler  = namedScratchpadAction myScratchPads "dolphin"
             myappkey  key = "C-t e " ++ key
             mygskey  key  = "C-t g " ++ key
             myRestart     = "for pid in `pgrep trayer`; do kill -9 $pid; done ;" ++
                         "for pid in `pgrep stalonetray`; do kill -9 $pid; done ;" ++
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
            , font              = myFontK10
            , bgColor           = "#2a2733"
            , fgColor           = "#909090"
            , bgHLight          = "#6b6382"
            , fgHLight          = "#4a4459"
            , defaultText       = ""
            , promptKeymap      =  myXPKeymap
              }

myWaitSP = myXPConfig { autoComplete   = Just 1000000 }

-- prompt keymap --------------------------------------
myXPKeymap = myXPKeymap' isSpace

-- | A variant of 'emacsLikeXPKeymap' which lets you specify a custom
--   predicate for identifying non-word characters, which affects all
--   the word-oriented commands (move\/kill word).  The default is
--   'isSpace'.  For example, by default a path like @foo\/bar\/baz@
--   would be considered as a single word.  You could use a predicate
--   like @(\\c -> isSpace c || c == \'\/\')@ to move through or
--   delete components of the path one at a time.
myXPKeymap'   :: (Char -> Bool) -> M.Map (KeyMask,KeySym) (XP ())
myXPKeymap' p = M.fromList $
  map (first $ (,) controlMask) -- control + <key>
  [ (xK_z, killBefore) --kill line backwards
  , (xK_k, killAfter) -- kill line fowards
  , (xK_a, startOfLine) --move to the beginning of the line
  , (xK_e, endOfLine) -- move to the end of the line
  , (xK_d, deleteString Next) -- delete a character foward
  , (xK_b, moveCursor Prev) -- move cursor forward
  , (xK_f, moveCursor Next) -- move cursor backward
  , (xK_BackSpace, killWord' p Prev) -- kill the previous word
  , (xK_y, pasteString)
  , (xK_g, quit)
  , (xK_bracketleft, quit)
  , (xK_m, setSuccess True >> setDone True)
  , (xK_h, deleteString Prev)
  ] ++
  map (first $ (,) mod1Mask) -- meta key + <key>
  [ (xK_BackSpace, killWord' p Prev)
  , (xK_f, moveWord' p Next) -- move a word forward
  , (xK_b, moveWord' p Prev) -- move a word backward
  , (xK_d, killWord' p Next) -- kill the next word
  , (xK_n, moveHistory W.focusUp')
  , (xK_p, moveHistory W.focusDown')
  ]
  ++
  map (first $ (,) 0) -- <key>
  [ (xK_Return, setSuccess True >> setDone True)
  , (xK_KP_Enter, setSuccess True >> setDone True)
  , (xK_BackSpace, deleteString Prev)
  , (xK_Delete, deleteString Next)
  , (xK_Left, moveCursor Prev)
  , (xK_Right, moveCursor Next)
  , (xK_Home, startOfLine)
  , (xK_End, endOfLine)
  , (xK_Down, moveHistory W.focusUp')
  , (xK_Up, moveHistory W.focusDown')
  , (xK_Escape, quit)
  ]



-- tabbar theme config ----------------------------------------
myTheme = defaultTheme {
activeTextColor     = "#909090"
, activeColor         = "#303030"
, fontName            = myTabFont
, decoHeight          = 13
}

-- manage hooks -------------------------------------------------------
-- myManageHook = -- insertPosition Master Newer <+> composeAll
myManageHook = insertPosition End Newer <+>
       ( composeAll  . concat $
        -- [ [isFullscreen                                       --> (doF W.focusDown <+> doFullFloat) ]
        [ [isFullscreen                                          --> doFullFloat ]
        , [isDialog                                              --> doFloat]

        , [className  =? "mlterm"                               --> viewShift "yksi"]

        , [(className =? c <||> title =? c <||> appName =? c)    --> doFloat | c <- myFloats ]
        , [className  =? "MPlayer"                               --> (doFloat <+> viewShift "kolme")]
        , [className  =? "mplayer2"                              --> (doFloat <+> viewShift "kolme")]
        , [className  =? "Vlc"                                   --> (doFloat <+> viewShift "kolme")]
        , [className  =? "Qmmp"                                  --> (doFloat <+> viewShift "kolme")]
        , [className  =? "Audacious"                             --> (doFloat <+> viewShift "kolme")]
        , [className  =? "gogglesmm"                             --> (doFloat <+> viewShift "kolme")]

        , [className  =? "V2C"                                   --> viewShift "kaksi"]
        , [className  =? "Opera"                                 --> viewShift "kaksi"]
        , [className  =? "Conkeror"                              --> viewShift "kaksi"]
        , [className  =? "Chrome"                               --> viewShift "kaksi"]
        , [className  =? "Xombrero"                               --> viewShift "kaksi"]
        , [className  =? "Otter"                               --> viewShift "kaksi"]
        , [className  =? "Firefox"                               --> viewShift "kaksi"]
        , [(className =? "Firefox" <&&> appName =? "Dialog")     --> (doFloat <+> viewShift "kaksi")]

        , [className  =? "feh"                                   --> viewShift "neljä"]
        , [appName    =? "sxiv"                                   --> viewShift "neljä"]
        , [className  =? "Mcomix"                                   --> viewShift "neljä"]
        , [className  =? "Comix"                                   --> viewShift "neljä"]
        , [className  =? "Thunar"                               --> viewShift "neljä"]
        , [className  =? "Dolphin"                               --> viewShift "neljä"]
        , [className  =? "Caja"                               --> viewShift "neljä"]
        , [className  =? "Pcmanfm"                               --> viewShift "neljä"]
        , [className  =? "ROX-Filer"                               --> viewShift "neljä"]
        , [className  =? "MComix"                               --> viewShift "neljä"]
        , [className  =? "Xfe"                               --> viewShift "neljä"]
        , [className  =? "Worker"                               --> viewShift "neljä"]
        , [className  =? "mpv"                                   --> (doFloat <+> viewShift "neljä")]
        , [className  =? "baka-mplayer"                                   --> (doFloat <+> viewShift "neljä")]

        , [className   =? "Emacs"                                --> viewShift "emacs"]

        , [className  =? "Xfce4-notifyd"                         --> doIgnore]
        , [className  =? "trayer"                                --> doIgnore]
        , [className  =? "stalonetray"                           --> doIgnore]
        -- , [appName =? ""]
        ])
         <+> namedScratchpadManageHook myScratchPads
         <+> manageDocks
         <+> manageHook defaultConfig

           where
         viewShift = doF . liftM2 (.) W.greedyView W.shift
         myFloats  = ["Main.py","Gimp","DTA","Gcolor2","Switch2","Uim-pref-gtk"
                    ,"Anki", "Install user style", "Vidalia"]

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
                ppCurrent         = (dzenColor "#fe974f" "") . pad
              , ppHidden          = (dzenColor "#a0a0a0" "") . pad
              , ppHiddenNoWindows = (dzenColor "#606060" "") . pad
              , ppLayout          = (dzenColor "#77a8bf" "") .
                                    (\x -> case x of
                                        "Full" -> wrapBitmap "sm4tik/xbm/full.xbm"
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
              , ppTitle           = wrap (dzenColor "#9e4f4a" "" "(") (dzenColor "#9e4f4a" "" ")")
              , ppVisible         = wrap "{" "}"
              , ppWsSep           = (dzenColor "#89b3c3" "" "::")
              , ppSep             = " | "
              , ppSort            = fmap (namedScratchpadFilterOutWorkspace.) (ppSort dzenPP)
              , ppOutput          = hPutStrLn h
                }
                  where
                  wrapBitmap bitmap = "^i(" ++ myIconsDirectory ++ bitmap ++ ")"
                  iconPad    a      = "^i(" ++ myIconsDirectory ++ a ++ " "


myEventHook = ewmhDesktopsEventHook

myStartupHook :: X ()
myStartupHook = do
                spawn myRightBar
                spawn trayer
                -- spawn mail
                -- spawn volumemgr
                {- spawn uimPanel -}
                execScriptHook "startup"

-- main config ---------------------------------------------------------------------
main     = myConfig
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
        , logHook            = myLogHook d >> takeTopFocus
        , startupHook        = myStartupHook
    } `additionalKeysP` myKeys
