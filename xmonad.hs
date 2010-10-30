
import XMonad
import XMonad.ManageHook

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers 
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.NoBorders
import XMonad.Layout.DecorationMadness

import XMonad.Prompt
import XMonad.Prompt.Shell

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

--------------------------------------------------------
-- keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
 -- , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu -fa Inconsolata -nb grey -nf white` && eval \"exec $exe\"")
    , ((modm,               xK_p     ), shellPrompt myXPConfig)

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

----------------------------------------------------
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


-- Layouts
myLayout = avoidStruts $ smartBorders $ (tallTabbed shrinkText (theme smallClean) ||| Full)
     
myManageHook = composeAll
    [ isFullscreen                  --> (doF W.focusDown <+> doFullFloat),
      className =? "MPlayer"        --> doFloat,
      className =? "Gimp"           --> doFloat,
      className =? "Thunar"         --> doFloat,
      className =? "Main.py"        --> doFloat,
      className =? "DTA"        --> doFloat,
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
        keys               = myKeys,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook d,
        startupHook        = myStartupHook
    }
