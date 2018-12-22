### Post Install Guide

Installing main package guide:

```
# --mflags --nocheck makes libgcc not run all the tests (like when installing discord)
yay -S --needed $( < pkglist.txt ) --mflags --nocheck
```

Download megasync:

```
cd Downloads
curl -O https://mega.nz/linux/MEGAsync/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.xz
sudo pacman -U megasync-x86_64.pkg.tar.xz
```
