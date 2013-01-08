module Mylib.Configs where
  import XMonad

  myTerminal       :: String
  myTerminal       = "mlclient"

  myBorderWidth    :: Dimension
  myBorderWidth    = 2

  myModMask        :: KeyMask
  -- mod1 = alt , mod4 = windows key
  myModMask        = mod4Mask
 
  myIconsDirectory :: String
  myIconsDirectory = "/home/mytoh/.dzen/icons/"

  myFocusFollowsMouse :: Bool
  myFocusFollowsMouse = False

  myWorkspaces  :: [[Char]]
  myWorkspaces  =
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
        -- wrapBitmap bitmap = "^i(" ++ myIconsDirectory ++ bitmap ++ ")"

  -- colors {{{
  myNormalBorderColor  :: String
  myNormalBorderColor  = "#111111"
  myFocusedBorderColor :: String
  myFocusedBorderColor = "#3d7df5"
  -- }}}

  -- Fonts -------------------------------------------
  myTabFont  :: String
  myTabFont  = "-*-terminus-medium-r-normal-*-12-*-*-*-*-*-iso10646-*"
  myXPFont   :: String
  myXPFont   = "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1"
  myDzenFont :: String
  myDzenFont = "-nil-profont-medium-r-normal--10-100-72-72-c-50-iso8859-1"
  -- myDzenFont = "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1"
  -- myDzenFont = "-jmk-neep-medium-r-normal--10-80-75-75-c-50-*"
  
