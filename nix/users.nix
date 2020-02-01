{ config, lib, pkgs, ... }:
let
  home-manager = import (builtins.fetchTarball "https://github.com/rycee/home-manager/archive/release-19.09.tar.gz") {};
in
{
  imports = [ home-manager.nixos ];
  users.users.johnpyp = {
    isNormalUser = true;
    home = "/home/johnpyp";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" "input" ];
    initialPassword = "johnpyp";
    shell = pkgs.zsh;
  };
  home-manager.users.johnpyp = {
    home.packages = with pkgs; [
      kate
      qutebrowser
    ];
    programs.home-manager = {
      enable = true;
    };
    xsession.windowManager.i3 = import ./home/i3.nix { pkgs = pkgs; };
  };
}
