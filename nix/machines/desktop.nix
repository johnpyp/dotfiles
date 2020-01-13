{ config, pkgs, ... }:
{
  imports = [
    ../modules/packages.nix
    ../modules/boot-efi.nix
    ../modules/ssh.nix
    ../modules/default-user.nix
    ../modules/sound.nix
    ../modules/xserver.nix
    ../modules/general.nix
    ../modules/networking.nix
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

  system.stateVersion = "19.09";
}
