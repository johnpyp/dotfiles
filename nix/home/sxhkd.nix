{ pkgs }:
{
  enable = true;
  keybindings = let
    mod = "mod4";
  in
    {
      "${mod} + {_, shift +} {h, j, k, l}" = "i3-msg {focus, move} {left, down, up, right}";
      "${mod} + {1-9}" = "i3-msg workspace number {1-9}";
      "${mod} + shift + {1-9}" = "i3-msg move container to workspace number {1-9}; workspace {1-9}";
      "${mod} + shift + {bracketleft, bracketright}" = "i3-msg move workspace to output {left, right}";
      "${mod} + {q, f}" = "i3-msg {split, fullscreen} toggle";
      "${mod} + shift + {c, r, q}" = "i3-msg {reload, restart, kill}";
      "${mod} + {r, 0}" = "i3-msg mode {resize, $mode_system}";
      "${mod} + shift + space" = "i3-msg floating toggle";
      "${mod} + x" = "i3-msg scratchpad show";
      "${mod} + shift + x" = "i3-msg scratchpad toggle";

      "${mod} + {grave, Tab}" = "${pkgs.rofi}/bin/rofi -show {drun, window} -modi drun,window -show-icons -sidebar-mode -theme Arc-Dark";
      "${mod} + d" = "${pkgs.rofi}/bin/rofi -show run -show-icons -theme Arc-Dark";

      "XF86MonBrightness{Down, Up}" = "light -{U, A} 10";
    };
}
