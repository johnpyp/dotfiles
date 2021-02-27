{ config, pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    # useDHCP = false;
    # nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
}
