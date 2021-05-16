{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: rec {
    via = pkgs.callPackage ./via {};
    gdlauncher = pkgs.callPackage ./gdlauncher {};
    ghstack = pkgs.callPackage ./ghstack {};
  };
}
