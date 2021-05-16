{ config, pkgs, ... }:
{
  imports = [
    ../../overrides
    ../../overlays
  ];

  nixpkgs.config.allowUnfree = true;
}
