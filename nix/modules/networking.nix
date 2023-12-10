{ config, pkgs, lib, ... }: {
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    nameservers = [ "192.168.1.1" "192.168.1.2" ];
  };
}
