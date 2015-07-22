import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops

-- Core
import XMonad
import System.IO
import System.Exit
import XMonad.Operations
import Data.Ratio ((%))
import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- Prompt
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)

-- Util 
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- Actions
import XMonad.Actions.CycleWS
 
-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
 
-- Layouts
import XMonad.Layout.Grid
import XMonad.Layout.LayoutHints
import XMonad.Layout.LayoutModifier
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.Reflect (reflectHoriz)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Tabbed
 


myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
      -- Prompt
      ((modMask, xK_p), spawn "dmenu_run") 
      -- Terminal
    , ((modMask .|. shiftMask, xK_Return ), spawn $ XMonad.terminal conf)
    -- kill selected window
    , ((modMask .|. shiftMask, xK_c ), kill)
    -- Media Keys
    , ((0, 0x1008ff06 ), spawn "sudo kbdlight down") 
    , ((0, 0x1008ff05 ), spawn "sudo kbdlight up") 
    , ((0, 0x1008ff03 ), spawn "xbacklight -10") 
    , ((0, 0x1008ff02 ), spawn "xbacklight +10") 
    , ((0, 0x1008ff4b ), spawn "sxiv -t -f -r ~/Pictures") 
    , ((0, 0x1008ff12 ), spawn "amixer -q sset Master toggle")  
    , ((0, 0x1008ff11 ), spawn "amixer -q sset Master 5%-") 
    , ((0, 0x1008ff13 ), spawn "amixer -q sset Master 5%+")
    -- adjust layouts
    , ((modMask, xK_space    ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space    ), setLayout $ XMonad.layoutHook conf)  
    -- toggle struts
    , ((modMask, xK_b ), sendMessage ToggleStruts)
    , ((modMask, xK_n ), refresh)
    -- move focus to next window
    , ((modMask, xK_Tab ), windows W.focusDown) 
    , ((modMask, xK_k ), windows W.focusDown)
    , ((modMask, xK_j ), windows W.focusUp  )
    -- swap the focused window 
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown)   
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp)    
    , ((modMask, xK_Return   ), windows W.swapMaster)
    -- push window back into tiling
    , ((modMask, xK_t ), withFocused $ windows . W.sink)  
    -- resize the master area
    , ((modMask, xK_h ), sendMessage Shrink)     
    , ((modMask, xK_l ), sendMessage Expand)   
    , ((modMask, xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask, xK_period ), sendMessage (IncMasterN (-1)))
    -- workspaces
    , ((modMask, xK_Right ), nextWS)
    , ((mod1Mask, xK_Tab ), nextWS)
    , ((modMask .|. shiftMask, xK_Right ), shiftToNext)
    , ((modMask, xK_Left ), prevWS)
    , ((modMask .|. shiftMask, xK_Left ), shiftToPrev)
    -- lock, quit, or restart
    , ((modMask .|. shiftMask, xK_l ), spawn "xset dpms foce off && slock")
    , ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    , ((modMask, xK_q ), spawn "killall conky dzen2 tint2 & xmonad --recompile && xmonad --restart")
    ]
    ++
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

main = xmonad $ defaultConfig
  { startupHook = setWMName "LG3D" >> takeTopFocus
  , manageHook = composeOne 
    [ transience
    , isFullscreen -?> doFullFloat ]
  , logHook = setWMName "LG3D" >> takeTopFocus
  , borderWidth = 0
  , keys = myKeys }

