{ config, lib, pkgs, ... }:
{
  users.users.johnpyp = {
    isNormalUser = true;
    home = "/home/johnpyp";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" "input" ];
    initialPassword = "johnpyp";
    shell = pkgs.zsh;
    subUidRanges = [
      { count = 65534; startUid = 100001; }
    ];
    subGidRanges = [
      { count = 65534; startGid = 100001; }
    ];
  };

}
