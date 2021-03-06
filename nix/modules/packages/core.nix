{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # pypi2nix
    acpi
    age
    alacritty
    alsaLib
    archiver
    atool
    awscli2
    bat
    bind
    binutils
    bottom
    caddy
    cargo
    chromedriver
    clang
    clangStdenv
    clojure
    cmake
    colordiff
    conda
    coursier
    curl
    deno
    di
    direnv
    docker
    docker-compose
    docui
    dotnet-sdk_3
    dotnetPackages.Nuget
    dpkg
    efibootmgr
    exa
    fd
    feh
    ffmpeg-full
    file
    fira
    fzf
    gallery-dl
    gcc
    git
    git-lfs
    git-quick-stats
    gitAndTools.hub
    github-cli
    glib
    glibc
    glxinfo
    gn
    gnumake
    go
    gparted
    gradle
    gtop
    gzip
    hashcat
    htop
    httpie
    imagemagick
    inxi
    iptables
    jpegoptim
    jq
    just
    keychain
    kind
    kitty
    kotlin
    ktlint
    kubectl
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
    lsof
    luarocks
    lutris
    magic-wormhole
    mediainfo
    mergerfs
    mergerfs-tools
    mono
    mosh
    mozjpeg
    mpv
    mypy
    ncdu
    neofetch
    neovim-remote
    nix-index
    nixfmt
    nixpkgs-fmt
    nodejs-14_x
    ntfsprogs
    omnisharp-roslyn
    openssl
    optipng
    osslsigncode
    p7zip
    parted
    pass
    patchelf
    pavucontrol
    peek
    pipenv
    piper
    pkg-config
    pngquant
    poetry
    postgresql
    psensor
    pwgen
    qbittorrent
    ranger
    redis
    ripgrep
    rnix-lsp
    rofi
    runc
    rustup
    sbt
    sccache
    signal-cli
    skim
    snapraid
    sops
    spotify
    spotify-tui
    spotifyd
    sshfs
    steam-run
    sumneko-lua-language-server
    sxhkd
    sysstat
    thefuck
    tldr
    tmux
    tokei
    trash-cli
    tree-sitter
    unrar
    unzip
    vim
    watchexec
    watchman
    wget
    wineStaging
    wireguard-tools
    xdg_utils
    yarn
    yarn2nix
    youtube-dl
    zafiro-icons
    zip
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
            mypy
            numpy
            pandas
            pygobject3
            pylint
            pynvim
            python-language-server
            pytorch
            requests
            scipy
            virtualenvwrapper
            yamllint
          ]
      )
    )
  ];
}
