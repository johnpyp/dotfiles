{ config, lib, pkgs, ... }:
let
  home-manager = import (builtins.fetchTarball "https://github.com/rycee/home-manager/archive/master.tar.gz") {};
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
    home.packages = (import ./home/packages.nix { pkgs = pkgs; }).packages;
    programs.home-manager = {
      enable = true;
    };
    # services.sxhkd = import ./home/sxhkd.nix { pkgs = pkgs; };
    # xsession.enable = true;
    # xsession.windowManager.i3 = import ./home/i3.nix { pkgs = pkgs; };
    xdg.configFile = {
      "sxhkd/sxhkdrc".source = ../dots/sxhkdrc;
      "i3/config".source = ../dots/i3/config;
    };
  };
}
