{ pkgs }:
{
  enable = true;
  keybindings = let
    mod = "mod4";
  in
    {
      "${mod} + {_,shift +} {h,j,k,l}" = "i3-msg {focus,move} {left,down,up,right}";
      "${mod} + shift + {c,r,q}" = "i3-msg {reload,restart,kill}";
      "${mod} + shift + {bracketleft,bracketright}" = "i3-msg move workspace to output {left,right}";
      "${mod} + shift + {1-9}" = "i3-msg move container to workspace number {1-9}; workspace {1-9}";
      "${mod} + shift + space" = "i3-msg floating toggle";
      "${mod} + shift + x" = "i3-msg scratchpad toggle";
      "${mod} + {r,0}" = "i3-msg mode {resize,\"lock-exit-off-suspend-hibernate-reboot-Shutdown\"}";
      "${mod} + {q,f}" = "i3-msg {split,fullscreen} toggle";
      "${mod} + {w,s,e}" = "i3-msg layout {tabbed,stacked,default}";
      "${mod} + {1-9}" = "i3-msg workspace number {1-9}";
      "${mod} + x" = "i3-msg scratchpad show";

      "${mod} + {grave,Tab}" = "rofi -show {drun, window} -modi drun,window -show-icons -sidebar-mode -theme Arc-Dark";
      "${mod} + d" = "rofi -show run -show-icons -theme Arc-Dark";

      "${mod} + p" = "flameshot gui";
      "Print" = "flameshot screen -c";

      "${mod} + Return" = "alacritty";

      "XF86MonBrightness{Down,Up}" = "light -{U,A} 10";
      "XF86Audio{RaiseVolume,LowerVolume,Mute}" = "amixer set Master {10%+,10%-,toggle}";
    };
}
