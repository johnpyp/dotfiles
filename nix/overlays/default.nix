{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import ./plex-media-player)
    (import ./mergerfs-tools)

    # (
    #   import (
    #     builtins.fetchTarball {
    #       url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    #     }
    #   )
    # )
    # (
    #
    #   (
    #     self: super: {
    #       discord = super.discord.overrideAttrs (
    #         _: {
    #           src = builtins.fetchTarball "https://discord.com/api/download?platform=linux&format=tar.gz";
    #         }
    #       );
    #     }
    #   )
    # )
  ];
}
