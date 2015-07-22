import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig 

main = xmonad $ defaultConfig
  { startupHook = setWMName "LG3D" >> takeTopFocus
  , manageHook = composeOne 
    [ transience
    , isFullscreen -?> doFullFloat ]
  , logHook = setWMName "LG3D" >> takeTopFocus
  , borderWidth = 0
  } `additionalKeys`
  [ ((0, 0x1008ff06 ), spawn "sudo kbdlight down") 
  , ((0, 0x1008ff05 ), spawn "sudo kbdlight up") 
  , ((0, 0x1008ff03 ), spawn "xbacklight -10") 
  , ((0, 0x1008ff02 ), spawn "xbacklight +10") 
  , ((0, 0x1008ff4b ), spawn "sxiv -t -f -r ~/Pictures") 
  , ((0, 0x1008ff12 ), spawn "amixer -q sset Master toggle")  
  , ((0, 0x1008ff11 ), spawn "amixer -q sset Master 5%-") 
  , ((0, 0x1008ff13 ), spawn "amixer -q sset Master 5%+")
  ]
