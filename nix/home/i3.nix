{ pkgs }:
{
  enable = true;
  package = pkgs.i3-gaps;
  config = {
    gaps = {
      inner = 8;
      outer = 4;
      smartBorders = "on";
      smartGaps = true;
    };
    bars = [];
    keybindings = let
      mod = "Mod1";
    in
      {
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+q" = "split toggle";
        "${mod}+f" = "fullscreen toggle";

        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+x" = "scratchpad show";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";

        "${mod}+Shift+1" = "move container to workspace number 1; workspace 1";
        "${mod}+Shift+2" = "move container to workspace number 2; workspace 2";
        "${mod}+Shift+3" = "move container to workspace number 3; workspace 3";
        "${mod}+Shift+4" = "move container to workspace number 4; workspace 4";
        "${mod}+Shift+5" = "move container to workspace number 5; workspace 5";
        "${mod}+Shift+6" = "move container to workspace number 6; workspace 6";
        "${mod}+Shift+7" = "move container to workspace number 7; workspace 7";
        "${mod}+Shift+8" = "move container to workspace number 8; workspace 8";

        "${mod}+Shift+bracketleft" = "move workspace to output left";
        "${mod}+Shift+bracketright" = "move workspace to output right";
        "XF86MonBrightnessDown" = "exec light -U 10";
        "XF86MonBrightnessUp" = "exec light -A 10";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";

        "${mod}+Shift+q" = "kill";

        "${mod}+grave" = "exec rofi -show drun -modi drun,window -show-icons -sidebar-mode -theme Arc-Dark";
        "${mod}+Tab" = "exec rofi -show window -modi drun,window -show-icons -sidebar-mode -theme Arc-Dark";
        "${mod}+d" = "exec rofi -show run -show-icons -theme Arc-Dark";

        "${mod}+r" = "mode \"resize\"";
        "${mod}+0" = "mode \"$mode_system\"";
      };
    window = {
      commands = [
        { criteria.class = "Pavucontrol"; command = "floating enable"; }
        { criteria.class = "Lxappearance"; command = "floating enable"; }
      ];
    };
    startup = [
      { command = "nm-applet"; notification = false; }
      { command = "~/.config/polybar/launch.sh"; always = true; notification = false; }
      { command = "feh --bg-fill $HOME/.config/wallpapers/current.jpg"; notification = false; }
      { command = "xautolock -time 30 -locker \"betterlockscreen -l dimblur\""; notification = false; }
      { command = "redshift-gtk"; notification = false; }
    ];
  };
  extraConfig =
    ''
      set $mode_system (l)ock, (e)xit, screens(o)ff, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown
      mode "$mode_system" {
          bindsym l exec --no-startup-id betterlockscreen -l dimblur, mode "default"
          bindsym o exec --no-startup-id $HOME/dotfiles/scripts/i3exit screensoff, mode "default"
          bindsym s exec --no-startup-id $HOME/dotfiles/scripts/i3exit suspend, mode "default"
          bindsym e exec --no-startup-id $HOME/dotfiles/scripts/i3exit logout, mode "default"
          bindsym h exec --no-startup-id $HOME/dotfiles/scripts/i3exit hibernate, mode "default"
          bindsym r exec --no-startup-id $HOME/dotfiles/scripts/i3exit reboot, mode "default"
          bindsym Shift+s exec --no-startup-id $HOME/dotfiles/scripts/i3exit shutdown, mode "default"

          # exit system mode: "Enter" or "Escape"
          bindsym Return mode "default"
          bindsym Escape mode "default"
      }

      # Resize window (you can also use the mouse for that)
      mode "resize" {
              bindsym h resize shrink width 5 px or 5 ppt
              bindsym j resize grow height 5 px or 5 ppt
              bindsym k resize shrink height 5 px or 5 ppt
              bindsym l resize grow width 5 px or 5 ppt

              # exit resize mode: Enter or Escape
              bindsym Return mode "default"
              bindsym Escape mode "default"
      }
    '';
}
