{ config, lib, pkgs, ... }:
{
  users.users.johnpyp = {
    isNormalUser = true;
    home = "/home/johnpyp";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" "input" ];
    initialPassword = "johnpyp";
    shell = pkgs.zsh;
  };
}
