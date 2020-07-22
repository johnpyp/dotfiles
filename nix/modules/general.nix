{ config, pkgs, ... }:
{
  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # Shell
  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];
  # Keybase
  services = {
    keybase.enable = true;
    kbfs.enable = true;
    kbfs.mountPoint = "/home/johnpyp/keybase";
    gnome3.gnome-keyring.enable = true;
    printing.enable = true;
  };
  # Fonts
  fonts = {
    enableFontDir = true;
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Cascadia Code" ];
      defaultFonts.sansSerif = [ "roboto" ];
      defaultFonts.serif = [ "roboto-slab" ];
      defaultFonts.emoji = [ "Noto Color Emoji" ];
    };
    fonts = with pkgs; [ nerdfonts cascadia-code ];
  };
}
