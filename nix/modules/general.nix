{ config, pkgs, ... }:
{
  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.liveRestore = false;
  # Shell
  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];

  # Keybase
  services = {
    keybase.enable = true;
    kbfs.enable = true;
    kbfs.mountPoint = "/home/johnpyp/keybase";
    gnome3.gnome-keyring.enable = true;
    printing.enable = true;
    spotifyd.enable = true;
  };
  # Fonts
  fonts = {
    fontDir = { enable = true; };
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Cascadia Code" ];
      defaultFonts.sansSerif = [ "roboto" ];
      defaultFonts.serif = [ "roboto-slab" ];
      defaultFonts.emoji = [ "Noto Color Emoji" ];
    };
    fonts = with pkgs; [ nerdfonts cascadia-code fira font-awesome powerline-fonts ];
  };
}
