# Manjaro Post Install Guide

Installing main package guide:

```sh
# --mflags --nocheck makes libgcc not run all the tests (like when installing discord)
yay -S --needed $( < pkglist.txt ) --mflags --nocheck
```

Install nvm:

```sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | zsh
# --> Close and reopen terminal
nvm install lts/dubnium
npm i -g npm
npm i -g yarn @vue/cli pm2 npm-check
```

Install (symlink) dotfiles:

```sh
cd ~/dotfiles
./install.sh
```

Download megasync:

```sh
cd Downloads
# Download built package
curl -O https://mega.nz/linux/MEGAsync/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.xz
# Install the local package
sudo pacman -U megasync-x86_64.pkg.tar.xz
```

Change Caps_Lock to Right:

```sh
# Edit Caps_Lock to Right on the Caps key
sudo mousepad /usr/share/X11/xkb/symbols/pc
# Reload layout
setxkbmap -layout us
```

Configure postgres:

```sh
# Become postgres user
sudo -u postgres -i
# Initialize database cluseter
initdb -D '/var/lib/postgres/data'
exit
# Enable and start postgres daemon
sudo systemctl enable postgresql.service
sudo systemctl start postgresql.service
sudo -u postgres -i
# Create postgres user (recommended to be same as login shell username)
createuser --interactive
```

Edit geoclue config to allow redshift:

```sh
sudo nano /etc/geoclue/geoclue.conf

# Add this to end of the file
[redshift]
allowed=true
system=false
users=
```

Install phoenix on elixir:

```sh
# Install hex
mix local.hex

# Install Phoenix Archive for generating a new app
mix archive.install hex phx_new 1.4.0
```
