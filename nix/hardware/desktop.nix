{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      "${modulesPath}/installer/scan/not-detected.nix"
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/d900347a-fc8c-4c41-b70d-5c71ba097a85";
      fsType = "ext4";
    };

  fileSystems."/vbox" =
    {
      device = "/dev/disk/by-uuid/7d1fae87-4847-44cc-8978-160e59adb2ac";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/3188-0945";
      fsType = "vfat";
    };

  swapDevices = [];
}
