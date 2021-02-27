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
        touchpad.accelProfile = "flat";
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
        # startx.enable = true;
        # gdm.enable = true;
        lightdm.enable = true;
      };
    };
  };

  # xdg.portal.enable = true;
  # xdg.portal.gtkUsePortal = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #
  # environment.variables = {
  #
  #   XDG_CURRENT_DESKTOP = "KDE";
  #   KDE_SESSION_VERSION = "5";
  #   ELECTRON_TRASH = "gio";
  # };
  # environment.loginShellInit = ''
  #   export XDG_CURRENT_DESKTOP="KDE"
  #   export KDE_SESSION_VERSION="5"
  #   if [ -e $HOME/.profile ]
  #   then
  #     . $HOME/.profile
  #   fi
  # '';
}
