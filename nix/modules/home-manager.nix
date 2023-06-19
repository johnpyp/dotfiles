{ config, pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.johnpyp = { pkgs, ... }: {

    # home.packages = [
    #   pkgs.neovim
    # ];
    # programs.neovim.enable = true;
    # programs.neovim.package = pkgs.neovim-nightly;
    programs.neovim = {
      enable = true;
      withPython3 = true;


      extraPackages = with pkgs; [
        (python3.withPackages (ps: with ps; [
          black
          flake8
          pyright
          pylint
          sh
        ]))
      ];
      extraPython3Packages = (ps: with ps; [
        jedi
        black
        flake8
        pylint
        sh
      ]);
    };

    programs.nix-index.enable = true;
    programs.nix-index.enableZshIntegration = true;

    home.stateVersion = "22.11";
  };
}
