{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    (import ./plex-media-player)
    inputs.neovim-nightly
  ];
}
