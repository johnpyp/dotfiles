{ config, pkgs, ... }:
{
  imports = [
    <nix-ld/modules/nix-ld.nix>
    ../modules/boot-efi.nix
    ../modules/general.nix
    ../modules/gui.nix
    ../modules/networking.nix
    ../modules/sound.nix
    ../modules/ssh.nix
    ../modules/users.nix
    ../modules/system-monitoring.nix
    ../modules/home-manager.nix

    ../modules/packages/base.nix
    ../modules/packages/core.nix
    ../modules/packages/desktop.nix
    # ../modules/wireguard.nix
  ];
  # Machine specific networking
  networking.hostName = "johnpyp-nixos-desktop";
  networking.interfaces.enp6s0.useDHCP = true;

  time.timeZone = "America/New_York";

  # Firewall, for plex
  networking.firewall.enable = false;
  services.lorri.enable = true;
  # hardware.nvidia.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option         "metamodes" "DP-4: 2560x1440_144 +1920+0 {ForceCompositionPipeline=On}, HDMI-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On}"
    '';
  };

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  hardware.pulseaudio.support32Bit = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.extraModulePackages = with config.boot.kernelPackages; [];


  services.flatpak.enable = true;
  xdg.portal.enable = true;


  services.udev.extraRules =
    ''
      echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"'

      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"
    '';
  boot.kernelParams = [ "systemd.unified_cgroup_hierarchy=false" ];
  system.stateVersion = "20.09";
}
