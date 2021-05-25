{ config, pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.johnpyp = { pkgs, ... }: {

    home.packages = [
      pkgs.neovim-nightly
    ];
    # programs.neovim.enable = true;
    # programs.neovim.package = pkgs.neovim-nightly;
    programs.neovim.withPython3 = true;

  };
}
