module Mylib.Configs where
  import XMonad

  myTerminal       :: String
  myTerminal       = "urxvtcd "

  myBorderWidth    :: Dimension
  myBorderWidth    = 2

  myModMask        :: KeyMask
  -- mod1 = alt , mod4 = windows key
  myModMask        = mod4Mask
 
  myIconsDirectory :: String
  myIconsDirectory = "/home/mytoh/.dzen/icons/"

  myFocusFollowsMouse :: Bool
  myFocusFollowsMouse = False
