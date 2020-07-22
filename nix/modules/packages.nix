{ config, pkgs, ... }:
{
  # environment.systemPackages = (import ../home/packages.nix {pkgs = pkgs;}).packages;
  environment.systemPackages = with pkgs; [
    # jdk12
    # openjdk8
    # rustup
    # firefox
    # libreoffice
    # nodejs-14_x
    # p7zip
    # podman
    acpi
    alacritty
    alsaLib
    bat
    betterlockscreen
    betterlockscreen
    bind
    binutils
    bitwarden
    brave
    caddy
    cargo
    chromium
    cinnamon.nemo
    clang
    clojure
    colordiff
    compton
    conda
    coursier
    crystal
    curl
    dbeaver
    deno
    di
    direnv
    discord
    docker
    docker-compose
    docui
    dotnet-sdk_3
    dotnetPackages.Nuget
    eclipses.eclipse-java
    efibootmgr
    emacs
    emacs-all-the-icons-fonts
    etcher
    exa
    exodus
    fd
    feh
    ffmpeg-full
    filezilla
    flameshot
    fzf
    gcc
    gimp
    git
    git-lfs
    gitAndTools.hub
    glib
    glibc
    gn
    gnome3.gnome-disk-utility
    gnome3.networkmanagerapplet
    gnome3.pomodoro
    gnumake
    go
    gparted
    gradle
    gtop
    hashcat
    htop
    httpie
    i3
    imagemagick
    insomnia
    iptables
    jdk11
    jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains.rider
    jetbrains.webstorm
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
    libreoffice-fresh
    libudev
    libwebp
    litecli
    llvmPackages.libclang
    lm_sensors
    lutris
    lxappearance
    mediainfo
    mergerfs
    mergerfs-tools
    minecraft
    mono
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
    nodejs-12_x
    ntfsprogs
    obs-studio
    okular
    omnisharp-roslyn
    openssl
    optipng
    pandoc
    papirus-icon-theme
    parted
    patchelf
    pavucontrol
    peek
    piper
    pkg-config
    pkg-config
    #plex-media-player
    pngquant
    polybarFull
    postgresql
    psensor
    qalculate-gtk
    qbittorrent
    qemu
    qpdf
    qutebrowser
    ranger
    redis
    redshift
    ripgrep
    rofi
    rofi
    rustc
    rxvt
    sbt
    shards
    skim
    snapraid
    spotify
    starship
    sublime
    sxhkd
    sysstat
    tldr
    tmux
    trash-cli
    unrar
    unzip
    vim
    vlc
    vscode
    watchman
    wget
    xautolock
    xfce.thunar
    # xfce4-14.xfce4-notifyd
    youtube-dl
    ytop
    zafiro-icons
    zlib
    zoom-us
    zsh
    zstd
    sshfs
    # brave-nightly


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
            mypy
            numpy
            pandas
            pygobject3
            pylint
            pylint
            python-language-server
            requests
            scipy
            virtualenvwrapper
          ]
      )
    )
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "p7zip-16.02"
  ];
  # nixpkgs.overlays = [
  #   (
  #     self: super: {
  #       brave-nightly = super.brave.overrideAttrs (old: rec {
  #         version = "1.12.68";
  #
  #         src = super.fetchurl {
  #
  #           url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser-nightly_${version}_amd64.deb";
  #           sha256 = "12jcna6lbpbhcxpnc8pm0kmy63axf3nvpd51i3prjanqk63r5yah";
  #         };
  #
  #       });
  #     }
  #   )
  #
  # ];
  nixpkgs.config.allowUnfree = true;
}
