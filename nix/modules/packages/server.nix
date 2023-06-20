{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bc
    btop
    csvkit
    dialog
    dmidecode
    fclones
    fio
    flashbench
    fselect
    gdu
    gptfdisk
    gum
    hddtemp
    ipmitool
    jql
    lshw
    neovim
    nix-init
    nix-update
    nodejs
    nushell
    pciutils
    sdparm
    sg3_utils
    smartmontools
    speedtest-cli
    tree
    units
    zpool-iostat-viz

    (python3.withPackages (ps: with ps; [ ]))
  ];
}
