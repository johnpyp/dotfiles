{ config, pkgs, ... }:
{
  # Keybase
  services = {
    keybase.enable = true;
    kbfs.enable = true;
    kbfs.mountPoint = "/home/johnpyp/keybase";
    gnome.gnome-keyring.enable = true;
    printing.enable = true;
    spotifyd.enable = true;
    cron.enable = true;
  };
}
