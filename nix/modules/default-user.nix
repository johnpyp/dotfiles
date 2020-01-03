{ config, pkgs, ... }:
{
  users.users.johnpyp = {
    isNormalUser = true;
    home = "/home/johnpyp";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" ];
    initialPassword = "johnpyp";
    shell = pkgs.zsh;
  };
}
