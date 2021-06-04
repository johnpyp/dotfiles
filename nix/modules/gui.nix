{ config, pkgs, ... }:
{

  programs.steam.enable = true;
  services = {
    picom = {
      enable = false;
    };
    xserver = {
      enable = true;
      xkbOptions = "caps:escape, compose:ralt, altwin:swap_alt_win";
      autoRepeatDelay = 150;
      autoRepeatInterval = 10;
      layout = "us";
      libinput = {
        enable = true;
        touchpad.accelProfile = "flat";
      };
      windowManager.i3.enable = true;
      windowManager.i3.package = pkgs.i3-gaps;

      # windowManager.bspwm.enable = true;

      desktopManager.xterm.enable = false;
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
        defaultSession = "none+i3";
        sessionCommands = ''
          ${pkgs.xfce.xfce4-notifyd}/lib/xfce4/notifyd/xfce4-notifyd &
          ${pkgs.autorandr}/bin/autorandr --change &
        '';
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
