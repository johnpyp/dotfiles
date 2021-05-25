{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { home-manager, nixpkgs, nix-ld, neovim-nightly, ... }@inputs:

    {

      nixosConfigurations = {
        johnpyp-nixos-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {

              nixpkgs.config = {
                system = "x86_64-linux";
                allowUnfree = true;
              };
            }
            ./hosts/desktop.nix
            home-manager.nixosModules.home-manager
            nix-ld.nixosModules.nix-ld
          ];

          specialArgs = { inherit inputs; };
        };
      };
    };
}
