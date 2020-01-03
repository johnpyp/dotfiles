{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    acpi
    betterlockscreen
    bitwarden
    clojure
    compton
    leiningen
    coursier
    crystal
    curl
    discord
    docker
    docker-compose
    dolphin
    exa
    exodus
    fd
    feh
    firefox
    flameshot
    fzf
    gcc
    git
    gitAndTools.hub
    gnome3.networkmanagerapplet
    go
    google-chrome
    gparted
    gradle
    clang
    htop
    insomnia
    jdk12
    jetbrains.idea-ultimate
    keybase-gui
    keychain
    kitty
    kotlin
    ktlint
    lxappearance-gtk3
    mypy
    ncdu
    neofetch
    neovim
    nixfmt
    nixpkgs-fmt
    nodejs-12_x
    okular
    openjdk
    parted
    pavucontrol
    qalculate-gtk
    ranger
    ripgrep
    rofi
    rustfmt
    rustup
    shards
    spotify
    unrar
    unzip
    vim
    vscode
    wget
    xautolock
    xfce4-14.xfce4-notifyd
    zafiro-icons
    zlib
    zsh
    zstd

    (
      python3.withPackages (
        ps:
          with ps; [
            beautifulsoup4
            dbus-python
            flask
            matplotlib
            numpy
            pandas
            pygobject3
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
        my-polybar = super.polybar.override {
          i3Support = true;
          pulseSupport = true;
        };
      }
    )
  ];
  nixpkgs.config.allowUnfree = true;
}
