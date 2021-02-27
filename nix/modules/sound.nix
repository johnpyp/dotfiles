{ config, pkgs, ... }:
{
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # services.spotifyd = {
  #   enable = true;
  #   config = ''
  #     [global]
  #     zeroconf_port = 5354
  #     backend = pulseaudio
  #     bitrate = 320
  #     password_cmd = cat /home/johnpyp/.credentials/spotify
  #   '';
  # };
  #
  # services.mopidy = {
  #   enable = true;
  #   extensionPackages = [ pkgs.mopidy-spotify ];
  # };
}
