{ config, pkgs, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.openssh.enable = true;
  programs.ssh.askPassword = "";
  programs.ssh.forwardX11 = true;
  services.openssh.forwardX11 = true;
}
