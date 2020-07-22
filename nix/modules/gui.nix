{ config, pkgs, ... }:
{
  services = {
    picom = {
      enable = true;
    };
    xserver = {
      enable = true;
      xkbOptions = "caps:escape, compose:ralt, altwin:swap_alt_win";
      autoRepeatDelay = 200;
      autoRepeatInterval = 10;
      layout = "us";
      libinput = {
        enable = true;
        accelProfile = "flat";
      };
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [ rofi polybarFull betterlockscreen ];
      };
      # desktopManager = {
      #   default = "xfce";
      #   xterm.enable = false;
      #   xfce.enable = true;
      # };
      # desktopManager.gnome3.enable = true;
      displayManager = {

        # gdm.enable = true;
        lightdm.enable = true;
      };
    };
  };
}
