module Mytoh.Config where
  import XMonad


  myBorderWidth    :: Dimension
  myBorderWidth    = 3

  myModMask        :: KeyMask
  -- mod1 = alt , mod4 = windows key
  myModMask        = mod4Mask

  myIconsDirectory :: String
  myIconsDirectory = "~/.xmonad/icons/"

  myFocusFollowsMouse :: Bool
  myFocusFollowsMouse = False

  myWorkspaces  :: [String]
  myWorkspaces  =
    [ "yksi"
    , "kaksi"
    , "kolme"
    , "neljä"
    , "emacs"
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
  myNormalBorderColor  :: String
  myNormalBorderColor  = "#111111"
  myFocusedBorderColor :: String
  myFocusedBorderColor = "#F92672"
  -- }}}

  -- Fonts -------------------------------------------
  myTabFont  :: String
  myTabFont  = "-*-terminus-medium-r-normal-*-12-*-*-*-*-*-iso10646-*"
  myXPFont   :: String
  myXPFont   = "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1"

  myFontK10 :: String
  myFontK10 = "-misc-fixed-medium-r-normal--10-*-75-75-c-50-*"
 
  myFontPro :: String
  myFontPro = "-nil-profont-medium-r-normal--10-100-72-72-c-50-iso8859-1"
  myFontArtwiz :: String
  myFontArtwiz = "-artwiz-limemod-medium-r-normal--10-110-75-75-m-50-iso8859-1"
  myFontNeep :: String
  myFontNeep = "-jmk-neep-medium-r-normal--10-80-75-75-c-50-*"

  myDzenFont :: String
  myDzenFont = myFontK10

