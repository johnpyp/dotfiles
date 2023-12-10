{ config, pkgs, ... }: {
  imports = [ ../../overrides ../../overlays ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
}
