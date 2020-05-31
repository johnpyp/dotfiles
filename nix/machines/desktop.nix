{ config, pkgs, ... }:
{
  imports = [
    ../modules/boot-efi.nix
    ../modules/general.nix
    ../modules/gui.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/sound.nix
    ../modules/ssh.nix
    ../modules/users.nix
    # ../modules/wireguard.nix
  ];
  # Machine specific networking
  networking.hostName = "johnpyp-nixos-desktop";
  networking.interfaces.enp7s0.useDHCP = true;

  time.timeZone = "America/New_York";

  # Firewall, for plex
  networking.firewall.enable = false;
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    screenSection =
      ''
        Option         "metamodes" "DVI-D-0: 1920x1080_144 +1920+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, HDMI-0: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, HDMI-1: nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      '';
    xrandrHeads = [
      { output = "HDMI-0"; }
      { output = "DVI-D-0"; primary = true; }
      { output = "HDMI-1"; }
    ];
  };
  # networking.wg-quick.interfaces.wg0 = {
  #   preUp = "${pkgs.nettools}/bin/route add -host $(${pkgs.curl}/bin/curl -s https://ipecho.net/plain) gw 192.168.1.1";
  #   postDown = "${pkgs.nettools}/bin/route del -host $(${pkgs.curl}/bin/curl -s https://ipecho.net/plain) gw 192.168.1.1";
  # };
  boot.kernelPackages = pkgs.linuxPackages;
  system.stateVersion = "20.09";
}
