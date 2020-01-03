{ config, pkgs, ... }:
{
  services = {
    gnome3.gnome-keyring.enable = true;
    printing.enable = true;
    compton = {
      enable = true;
    };
    xserver = {
      enable = true;
      xkbOptions = "caps:escape";
      autoRepeatDelay = 200;
      autoRepeatInterval = 100;
      layout = "us";
      libinput = {
        enable = true;
        accelProfile = "flat";
      };
      windowManager.default = "i3";
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [ rofi my-polybar betterlockscreen ];
      };
      desktopManager = {
        default = "none";
        xterm.enable = false;
      };
      displayManager.lightdm.enable = true;
    };
  };
}
