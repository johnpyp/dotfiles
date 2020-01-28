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
    };
    fonts = with pkgs; [ nerdfonts cascadia-code ];
  };
  security.sudo.extraRules = [
    {
      commands = [
        { command = "${pkgs.wireguard}/bin/wg-quick"; options = [ "NOPASSWD" ]; }
        { command = "${pkgs.wireguard}/bin/wg"; options = [ "NOPASSWD" ]; }
      ];
      groups = [ "wheel" ];
    }
  ];

  environment.variables = {
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang}/lib";
  };
}
