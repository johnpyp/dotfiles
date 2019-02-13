# Manjaro Post Install Guide

Installing main package guide:

```sh
# --mflags --nocheck makes libgcc not run all the tests (like when installing discord)
yay -S --needed $( < pkglist.txt ) --mflags --nocheck
```

Install fnm:

```sh
curl https://raw.githubusercontent.com/Schniz/fnm/master/.ci/install.sh | bash
fnm install latest
npm i -g npm
npm i -g yarn
yarn global add ...
```

Install prezto:

```
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
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
