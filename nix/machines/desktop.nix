{ config, pkgs, ... }:
{
  imports = [
    <nix-ld/modules/nix-ld.nix>
    ../modules/boot-efi.nix
    ../modules/general.nix
    ../modules/gui.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/sound.nix
    ../modules/ssh.nix
    ../modules/users.nix
    ../modules/system-monitoring.nix
    ../modules/home-manager.nix
    # ../modules/wireguard.nix
  ];
  # Machine specific networking
  networking.hostName = "johnpyp-nixos-desktop";
  networking.interfaces.enp8s0.useDHCP = true;

  time.timeZone = "America/New_York";

  # Firewall, for plex
  networking.firewall.enable = false;
  services.lorri.enable = true;
  # hardware.nvidia.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  services.xserver = {
    videoDrivers = ["nvidia"];
    xrandrHeads = [
      { output = "DP-3"; }
      { output = "DP-2"; primary = true; }
      { output = "HDMI-0"; }
    ];
    screenSection =
      ''
    Option         "metamodes" "HDMI-0: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: 1920x1080_144 +1920+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, HDMI-1: nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      '';
  };

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  hardware.openrazer.enable = true;
  hardware.pulseaudio.support32Bit = true;
  # hardware.openrazer.enable = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.extraModulePackages = with config.boot.kernelPackages; [ wireguard ];
  system.stateVersion = "20.09";
}
