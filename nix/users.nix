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
    # xdg.configFile = {
    #   "i3/config".source = ../dots/i3/config;
    #   "polybar/".source = ../dots/polybar;
    #   "pscripts/".source = ../dots/pscripts;
    #   "nvim/init.vim".source = ../dots/nvim/init.vim;
    #   "nvim/coc-settings.json".source = ../dots/nvim/coc-settings.json;
    #   "starship.toml".source = ../dots/starship.toml;
    # };
  };
}
