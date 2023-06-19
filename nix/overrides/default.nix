{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: rec {
    via = pkgs.callPackage ./via { };
    gdlauncher = pkgs.callPackage ./gdlauncher { };
    # ghstack = pkgs.callPackage ./ghstack {};
    # importlib-metadata = pkgs.callPackage ./ghstack {};
    arc = import
      (builtins.fetchTarball "https://github.com/arcnmx/nixexprs/archive/master.tar.gz")
      {
        inherit pkgs;
      };
  };
}
