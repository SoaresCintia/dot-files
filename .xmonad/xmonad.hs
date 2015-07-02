import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops

main = xmonad $ defaultConfig
    {
        startupHook = setWMName "LG3D" >> takeTopFocus,
        manageHook = composeOne [
            transience,
            isFullscreen -?> doFullFloat
        ],
        logHook = setWMName "LG3D" >> takeTopFocus,
	borderWidth = 0
    }

