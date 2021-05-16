{ config, pkgs, ... }:
{
  imports = [
    # ../modules/sound.nix
    ../modules/boot-efi.nix
    ../modules/general.nix
    ../modules/gui.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/ssh.nix
    ../modules/users.nix
  ];
  # Machine specific networking
  networking.hostName = "johnpyp-nixos-server";
  networking.interfaces.enp4s0.useDHCP = true;

  time.timeZone = "America/New_York";

  # Firewall, for plex
  networking.firewall.enable = false;

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelParams = [ "systemd.unified_cgroup_hierarchy=false" ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  # sshd for remote ssh
  services.sshd.enable = true;

  system.stateVersion = "20.09";

  services.samba = {
    enable = true;
    securityType = "user";
    enableNmbd = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = Samba Nix
      netbios name = Samba Nix
      server role = standalone server
      ;log file = /var/log/samba/smbd.%m
      ;max log size = 50
      ;dns proxy = no
      ;hosts allow = 192.168.0  localhost  192.168.1
      ;hosts deny = 0.0.0.0/0
      ;map to guest = Bad User
    '';
    shares = {
      private = {
        path = "/virt";
        browseable = "yes";
        writable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "johnpyp";
        "force group" = "users";
      };
    };
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "8096";
    }
  ];

  services.openssh.allowSFTP = true;
}
