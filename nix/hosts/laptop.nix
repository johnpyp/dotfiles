{ config, pkgs, ... }:
{
  imports = [
    ../modules/bluetooth.nix
    ../modules/boot-efi.nix
    ../modules/general.nix
    ../modules/gui.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/sound.nix
    ../modules/ssh.nix
    ../modules/users.nix
    ../modules/wireguard.nix
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

  system.stateVersion = "20.03";
}
