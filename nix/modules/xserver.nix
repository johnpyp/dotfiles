{ config, pkgs, ... }:
{
  services = {
    compton = {
      enable = true;
    };
    xserver = {
      enable = true;
      xkbOptions = "caps:escape, compose:ralt";
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
        extraPackages = with pkgs; [ rofi my-polybar betterlockscreen ];
      };
      desktopManager = {
        xterm.enable = false;
      };
      displayManager = {
        defaultSession = "none+i3";
        lightdm.enable = true;
      };
    };
  };
}
