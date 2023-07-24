{ config, pkgs, ... }: {
  imports = [
    ../modules/boot-efi.nix
    ../modules/general.nix
    ../modules/xfce-gui.nix
    ../modules/networking.nix
    ../modules/ssh.nix
    ../modules/users.nix
    ../modules/home-manager.nix
    ../modules/locale.nix

    ../modules/packages/base.nix
    ../modules/packages/core.nix
    ../modules/packages/server.nix
  ];
  # Machine specific networking
  networking.hostName = "vex";
  networking.hostId = "808fe478"; # Zfs requires hostId

  time.timeZone = "America/Los_Angeles";

  # Firewall, for plex
  networking.firewall.enable = false;

  networking.interfaces.enp6s18.ipv4.addresses = [{
    address = "192.168.1.90";
    prefixLength = 24;
  }];
  boot.kernel.sysctl."net.ipv6.conf.enp6s18.disable_ipv6" = true;

  networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "192.168.1.1" ];

  # virtualisation.vmware.guest.enable = true;
  # Vex is on Proxmox (QEMU)!
  # virtualisation.qemu.guestAgent.enable = true;
  services.qemuGuest.enable = true;

  services.lorri.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
  # hardware.nvidia.modesetting.enable = true;

  # hardware.nvidia.open = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;

  # hardware.nvidia.package = pkgs.arc.packages.nvidia-patch.override {
  #   nvidia_x11 = config.boot.kernelPackages.nvidiaPackages.beta;
  # };
  # pkgs.arc.packages.nvidia-patch.override {
  #   nvidia_x11 = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  # };

  services.k3s = {
    enable = false;
    role = "server";
  };

  # services.k3s.extraFlags = toString [
  #   "--kube-apiserver-arg="
  #   # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  # ];

  ###########
  ### ZFS ###

  # ZFS may not support the latest version of linux
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  # # boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelParams = [
    # "systemd.unified_cgroup_hierarchy=false"
    # "zfs.zfs_arc_max=34359738368" # Set max size of ARC to 32GiB
  ];

  # l2arc_noprefetch=0 -> Allow prefetch
  # l2arc_rebuild_enabled=1 -> Persist l2arc across reboots
  # l2arc_headroom=0 -> Allow l2arc to apply to entire ARC cache
  # zfs_arc_meta_min=10737418240 = 10GiB -> Minimum size of the arc metadata cache
  # zfetch_array_rd_sz=1073741824 = 1GiB -> Allow prefetching blocks up to a GiB
  # zfetch_max_distance=2516582400 = 2400MiB -> Set possible preset chunks to 2400MB to increase raidz2 read perf https://github.com/openzfs/zfs/issues/9375#issuecomment-536333826
  # l2arc_write_max=67108864 = 64MiB -> Set rate of fill to 64MB/s for l2arc cache
  # l2arc_write_boost=67108864 = 64MiB -> ^^
  # zfs_special_class_metadata_reserve_pct=10 = 20% -> 20% of special vdev reserved for metadata always (default 25%)
  # l2arc_exclude_special=1 -> Make it so that l2arc will not cache special-vdev content, as the nvmes are plenty fast
  # boot.extraModprobeConfig = ''
  #   options zfs l2arc_noprefetch=0 l2arc_rebuild_enabled=1 l2arc_headroom=0 zfs_arc_meta_min=10737418240 zfetch_array_rd_sz=1073741824 zfetch_max_distance=2516582400 l2arc_write_max=67108864 l2arc_write_boost=67108864 zfs_special_class_metadata_reserve_pct=20 l2arc_exclude_special=1
  # '';

  # Support ZFS on nixos
  # https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html#installation
  boot.supportedFilesystems = [ "zfs" "xfs" ];
  boot.zfs.extraPools = [ ];
  boot.zfs.devNodes =
    "/dev/disk/by-id"; # /dev/disk/by-id is the default, but we want to make sure just in case it changes, as this is important so the pool doesn't get imported out of order
  services.nfs.server.enable = true;

  # boot.zfs.enabled = true; # Unnecessary, because `boot.supportedFilesystems` has "zfs" in it
  boot.zfs.forceImportRoot = false;

  # Enable ZFS autoscrub, defaults to once a week
  # services.zfs.autoScrub.enable = true;

  ### ZFS ###
  ###########

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  # sshd for remote ssh
  services.sshd.enable = true;

  services.eternal-terminal = { enable = true; };

  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "8096";
  }];

  services.openssh.allowSFTP = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
