{ config, pkgs, ... }:
{
  # Docker
  virtualisation.docker.enable = true;
  # Shell
  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];
  # Keybase
  services = {
    keybase.enable = true;
    kbfs.enable = true;
    kbfs.mountPoint = "/home/johnpyp/keybase";
  };
  # Fonts
  fonts = {
    enableFontDir = true;
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Cascadia Code" ];
      defaultFonts.sansSerif = [ "roboto" ];
      defaultFonts.serif = [ "roboto-slab" ];
    };
    fonts = with pkgs; [ nerdfonts cascadia-code ];
  };
  # Gnome keyring
  services.gnome3.gnome-keyring.enable = true;
  # Printing
  services.printing.enable = true;
}
