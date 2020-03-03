{ config, pkgs, ... }:
{
  # environment.systemPackages = (import ../home/packages.nix {pkgs = pkgs;}).packages;
  environment.systemPackages = with pkgs; [
    # jdk12
    # openjdk8
    acpi
    alacritty
    alsaLib
    bat
    betterlockscreen
    bind
    binutils
    bitwarden
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
    discord
    docker
    docker-compose
    eclipses.eclipse-java
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
    jetbrains.idea-ultimate
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
    libreoffice
    libudev
    libwebp
    llvmPackages.libclang
    lm_sensors
    lutris
    lxappearance-gtk3
    mergerfs
    mergerfs-tools
    minecraft
    mozjpeg
    mpv
    multibootusb
    multimc
    mypy
    ncdu
    neofetch
    neovim
    nix-index
    nixpkgs-fmt
    nodejs-13_x
    ntfsprogs
    obs-studio
    okular
    openjdk
    optipng
    p7zip
    papirus-icon-theme
    parted
    patchelf
    pavucontrol
    peek
    piper
    pkg-config
    plex-media-player
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
    scry
    shards
    skim
    spotify
    starship
    sxhkd
    tldr
    tmux
    unrar
    unzip
    vim
    wget
    xautolock
    xfce.thunar
    xfce4-14.xfce4-notifyd
    youtube-dl
    ytop
    zafiro-icons
    zlib
    zsh
    zstd


    (
      python3.withPackages (
        ps:
          with ps; [
            beautifulsoup4
            black
            dbus-python
            flask
            jedi
            matplotlib
            numpy
            pandas
            pygobject3
            pylint
            requests
            scipy
            virtualenvwrapper
          ]
      )
    )
  ];
  nixpkgs.overlays = [];
  nixpkgs.config.allowUnfree = true;
}
