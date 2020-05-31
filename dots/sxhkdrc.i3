XF86MonBrightness{Down,Up}
  light -{U,A} 10

XF86Audio{RaiseVolume,LowerVolume,Mute}
  amixer set Master {10%+,10%-,toggle}

mod4 + shift + space
  i3-msg floating toggle

mod4 + shift + {1-9}
  i3-msg move container to workspace number {1-9}; i3-msg workspace {1-9}

mod4 + shift + {bracketleft,bracketright}
  i3-msg move workspace to output {left,right}

mod4 + shift + {c,r,q}
  i3-msg {reload,restart,kill}

mod4 + {_,shift +} x
  i3-msg scratchpad {show,toggle}

mod4 + {1-9}
  i3-msg workspace number {1-9}

mod4 + {_,shift +} {h,j,k,l}
  i3-msg {focus,move} {left,down,up,right}

mod4 + {w,s,e}
  i3-msg layout {tabbed,stacked,default}

mod4 + {grave,Tab}
  rofi -show {drun,window} -modi drun,window -show-icons -sidebar-mode -theme Arc-Dark

mod4 + d
  rofi -show run -show-icons -theme Arc-Dark

mod4 + {q,f}
  i3-msg {split,fullscreen} toggle

mod4 + r
  i3-msg mode resize

mod4 + 0
  i3-msg mode "lock-exit-off-suspend-hibernate-reboot-Shutdown"

mod4 + Return
  alacritty

mod4 + Escape
  pkill sxhkd; sleep 1; sxhkd &; $HOME/.config/polybar/launch.sh

mod4 + p
  flameshot gui

Print
  flameshot screen -c