{ config, pkgs, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  programs.ssh.forwardX11 = true;
  programs.ssh.askPassword = "";
}
