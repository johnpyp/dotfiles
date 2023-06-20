{ config, pkgs, lib, ... }:
{
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    nameservers = [ "192.168.1.1" "8.8.8.8" "8.8.4.4" "1.1.1.1" "1.0.0.1" ];
  };
}
