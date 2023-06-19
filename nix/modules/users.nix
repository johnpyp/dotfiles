{ config, lib, pkgs, ... }:
{
  users.users.johnpyp = {
    name = "johnpyp";
    description = "johnpyp";
    uid = 1000;
    home = "/home/johnpyp";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" "input" "user-with-access-to-virtualbox" "plugdev" "wireshark" "adbusers" "sambashare" "smartctl" ];
    isNormalUser = true;
    initialPassword = "johnpyp";
    shell = pkgs.zsh;
    subUidRanges = [
      { count = 65534; startUid = 100001; }
    ];
    subGidRanges = [
      { count = 65534; startGid = 100001; }
    ];
  };

  # users.groups.johnpyp = {
  #   name = "johnpyp";
  #   members = ["johnpyp"];
  #   gid = 1000;
  # };

}
