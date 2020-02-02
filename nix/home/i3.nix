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
    keybindings = {};
    window = {
      commands = [
        { criteria.class = "Pavucontrol"; command = "floating enable"; }
        { criteria.class = "Lxappearance"; command = "floating enable"; }
      ];
    };
    startup = [
      { command = "nm-applet"; notification = false; }
      { command = "$HOME/.config/polybar/launch.sh"; always = true; notification = false; }
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
