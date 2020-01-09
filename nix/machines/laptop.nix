{ config, pkgs, ... }:
{
  imports = [
    ../modules/packages.nix
    ../modules/boot-efi.nix
    ../modules/ssh.nix
    ../modules/default-user.nix
    ../modules/bluetooth.nix
    ../modules/sound.nix
    ../modules/xserver.nix
    ../modules/general.nix
  ];
  # Machine specific networking
  networking = import ../modules/networking.nix "wlp2s0";

  time.timeZone = "America/New_York";

  # Machine spefific desktop stuff
  programs.light.enable = true;
  services.compton.vSync = true;
  services.compton.backend = "glx";
  services.tlp.enable = true;
  services.logind.lidSwitch = "suspend";

  system.stateVersion = "19.09";
}
