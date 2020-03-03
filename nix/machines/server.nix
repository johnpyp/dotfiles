{ config, pkgs, ... }:
{
  imports = [
    # ../modules/sound.nix
    ../modules/boot-efi.nix
    ../modules/general.nix
    ../modules/gui.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/ssh.nix
    ../modules/users.nix
  ];
  # Machine specific networking
  networking.hostName = "johnpyp-nixos-server";
  networking.interfaces.enp4s0.useDHCP = true;

  time.timeZone = "America/New_York";

  # Firewall, for plex
  networking.firewall.enable = false;

  # sshd for remote ssh
  services.sshd.enable = true;

  system.stateVersion = "20.09";
}
