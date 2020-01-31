{ config, pkgs, ... }:
{
  imports = [
    ../modules/packages.nix
    ../modules/boot-efi.nix
    ../modules/ssh.nix
    ../modules/bluetooth.nix
    ../modules/sound.nix
    ../modules/xserver.nix
    ../modules/general.nix
    ../modules/networking.nix
    ../users.nix
  ];
  # Machine specific networking
  networking.hostName = "johnpyp-nixos-laptop";
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.wireguard.enable = true;

  time.timeZone = "America/New_York";

  # Machine spefific desktop stuff
  programs.light.enable = true;
  services.compton.vSync = true;
  services.compton.backend = "glx";
  services.tlp.enable = true;
  services.logind.lidSwitch = "suspend";

  system.stateVersion = "19.09";
}
