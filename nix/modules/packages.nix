{ config, pkgs, ... }:
{
  # environment.systemPackages = (import ../home/packages.nix {pkgs = pkgs;}).packages;
  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    alsaLib
    atool
    awscli2
    bat
    betterdiscordctl
    betterlockscreen
    bind
    binutils
    bitwarden
    bottom
    brave
    caddy
    cargo
    chromedriver
    chromium
    clang
    clojure
    colordiff
    compton
    conda
    coursier
    curl
    dbeaver
    deluge
    deno
    di
    direnv
    discord
    docker
    docker-compose
    docui
    dolphin
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
    file
    filezilla
    fira
    flameshot
    fzf
    gallery-dl
    gcc
    gimp
    git
    git-lfs
    gitAndTools.hub
    github-cli
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
    gzip
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
    lazygit
    leiningen
    libmediainfo
    libnotify
    libpqxx
    libratbag
    libreoffice-fresh
    libudev
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
    multimc
    mypy
    ncdu
    neofetch
    nix-index
    nixpkgs-fmt
    nodejs-14_x
    nordic
    ntfsprogs
    obs-studio
    okular
    omnisharp-roslyn
    openssl
    optipng
    p7zip
    pandoc
    pantheon.elementary-gtk-theme
    papirus-icon-theme
    parted
    patchelf
    pavucontrol
    peek
    pipenv
    piper
    pkg-config
    plex-media-player
    pngquant
    poetry
    poetry
    polybarFull
    pop-gtk-theme
    postgresql
    protontricks
    psensor
    qbittorrent
    ranger
    redis
    redshift
    ripgrep
    rustup
    rxvt
    sbt
    sccache
    skim
    snapraid
    spotify
    pass
    sshfs
    starship
    steam
    sublime
    sxhkd
    sysstat
    tldr
    tmux
    trash-cli
    unrar
    unzip
    vim
    vimix-gtk-themes
    vlc
    vscode
    watchman
    wget
    wireguard-tools
    xautolock
    xfce.thunar
    xfce.xfce4-notifyd
    youtube-dl
    zafiro-icons
    zip
    zlib
    zoom-us
    zsh
    zstd
    xdg_utils


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
            pynvim
            pygobject3
            pylint
            python-language-server
            pytorch
            requests
            scipy
            virtualenvwrapper
          ]
      )
    )
  ];

  # nixpkgs.config.permittedInsecurePackages = [
  #   "p7zip-16.02"
  # ];
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

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  nixpkgs.config.allowUnfree = true;
}
