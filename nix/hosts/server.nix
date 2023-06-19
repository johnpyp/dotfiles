{ config, pkgs, ... }:
{
  imports = [
    # ../modules/sound.nix
    ../modules/boot-efi.nix
    ../modules/general.nix
    ../modules/gui.nix
    ../modules/networking.nix
    ../modules/ssh.nix
    ../modules/users.nix
    ../modules/system-monitoring.nix
    ../modules/home-manager.nix

    ../modules/packages/base.nix
    ../modules/packages/core.nix
    # ../modules/elastic-monitoring.nix
    # ../modules/packages/desktop.nix
  ];
  # Machine specific networking
  networking.hostName = "johnpyp-nixos-server";
  # networking.interfaces.enp4s0.useDHCP = true;

  boot.kernel.sysctl."net.ipv6.conf.enp5s0.disable_ipv6" = true;
  time.timeZone = "America/New_York";

  # Firewall, for plex
  networking.firewall.enable = false;

  services.lorri.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.package = pkgs.arc.packages.nvidia-patch.override {
    nvidia_x11 = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  ###########
  ### ZFS ###

  # ZFS may not support the latest version of linux
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  # boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelParams = [
    "systemd.unified_cgroup_hierarchy=false"
    "zfs.zfs_arc_max=17179869184" # Set max size of ARC to 20GiB

  ];

  # l2arc_noprefetch=0 -> Allow prefetch
  # l2arc_rebuild_enabled=1 -> Persist l2arc across reboots
  # l2arc_headroom=0 -> Allow l2arc to apply to entire ARC cache
  # zfs_arc_meta_min -> Minimum size of the arc metadata cache
  # zfetch_array_rd_sz=1073741824 = 1GiB -> Allow prefetching blocks up to a GiB
  # zfetch_max_distance=2516582400 = 2400MiB -> Set possible preset chunks to 2400MB to increase raidz2 read perf https://github.com/openzfs/zfs/issues/9375#issuecomment-536333826
  # l2arc_write_max=67108864 = 64MiB -> Set rate of fill to 64MB/s for l2arc cache
  # l2arc_write_boost=67108864 = 64MiB -> ^^
  boot.extraModprobeConfig = ''
    options zfs l2arc_noprefetch=0 l2arc_rebuild_enabled=1 l2arc_headroom=0 zfs_arc_meta_min=4294967296 zfetch_array_rd_sz=1073741824 zfetch_max_distance=2516582400 l2arc_write_max=67108864 l2arc_write_boost=67108864
  '';

  # Support ZFS on nixos
  # https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html#installation
  boot.supportedFilesystems = [ "zfs" "xfs" ];
  boot.zfs.extraPools = [ "tank" ];
  boot.zfs.devNodes = "/dev/disk/by-id"; # /dev/disk/by-id is the default, but we want to make sure just in case it changes, as this is important so the pool doesn't get imported out of order
  services.nfs.server.enable = true;


  # boot.zfs.enabled = true; # Unnecessary, because `boot.supportedFilesystems` has "zfs" in it
  boot.zfs.forceImportRoot = false;
  networking.hostId = "4b083a24"; # ZFS requires a host id I guess

  # Enable ZFS autoscrub, defaults to once a week
  services.zfs.autoScrub.enable = true;

  ### ZFS ###
  ###########

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  # sshd for remote ssh
  services.sshd.enable = true;

  services.eternal-terminal = {
    enable = true;
  };

  system.stateVersion = "22.05";

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
