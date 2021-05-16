{ config, pkgs, ... }:
{
  # environment.systemPackages = (import ../home/packages.nix {pkgs = pkgs;}).packages;
  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    alsaLib
    bat
    betterlockscreen
    bind
    binutils
    bitwarden
    bottom
    brave
    chromium
    clang
    clojure
    compton
    conda
    coursier
    crystal
    curl
    di
    docker
    docker-compose
    etcher
    exa
    exodus
    fd
    feh
    filezilla
    firefox
    flameshot
    fzf
    gimp
    git
    gitAndTools.hub
    glib
    glibc
    gn
    gnome3.gnome-disk-utility
    gnome3.networkmanagerapplet
    gnome3.pomodoro
    go
    gparted
    gradle
    hashcat
    htop
    i3
    imagemagick
    insomnia
    iptables
    jpegoptim
    jq
    just
    keybase-gui
    keychain
    kitty
    kotlin
    krita
    ktlint
    lazydocker
    leiningen
    libmediainfo
    libnotify
    libpqxx
    libratbag
    libudev
    libwebp
    llvmPackages.libclang
    lm_sensors
    lutris
    lxappearance
    mergerfs
    minecraft
    mozjpeg
    mpv
    mypy
    ncdu
    neofetch
    neovim
    nix-index
    nixpkgs-fmt
    nodejs-14_x
    ntfsprogs
    obs-studio
    okular
    openjdk
    optipng
    papirus-icon-theme
    parted
    patchelf
    pavucontrol
    peek
    piper
    pkg-config
    pngquant
    postgresql
    psensor
    qalculate-gtk
    qbittorrent
    qemu
    qutebrowser
    ranger
    redshift
    ripgrep
    rofi
    rustup
    rxvt
    shards
    skim
    sops
    starship
    sxhkd
    tldr
    tmux
    vim
    wget
    xautolock
    xfce.thunar
    xfce4-14.xfce4-notifyd
    xorg.xauth
    youtube-dl
    zafiro-icons
    zlib
    zsh
    zstd


    (
      python37.withPackages (
        ps:
          with ps; [
            beautifulsoup4
            black
            # dbus-python
            tldextract
            flask
            jedi
            matplotlib
            numpy
            #pandas
            pygobject3
            pylint
            requests
            scipy
            virtualenvwrapper
          ]
      )
    )
  ];
  nixpkgs.overlays = [
    (
      self: super: {
        my-mergerfs = super.mergerfs.overrideAttrs (old: rec {
          pname = "mergerfs";
          version = "master";
          src = super.fetchFromGitHub {
            owner = "trapexit";
            rev = version;
            repo = pname;
            sha256 = "0p2fk5d3ywq2qxpkz7ry7s6hpyh9k4pnaxkykfiqv6l8vgkm4ycn";
          };
        });
      }
    )

    (
      self: super: {
        my-minecraft-server = super.minecraft-server.overrideAttrs (old: rec {
          version = "1.16.1";

          src = super.fetchurl {
            url = "https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar";
            sha256 = "0nwkdig6yw4cnm2ld78z4j4xzhbm1rwv55vfxz0gzhsbf93xb0i7";
          };

        });
      }
    )

  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "p7zip-16.02"
  ];
}
