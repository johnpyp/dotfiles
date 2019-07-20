# DISCLAIMER: I WOULDN'T TRUST ME, WHY SHOULD YOU ???

## Manjaro/Arch Post Install Guide

Ranking mirrors:
```sh
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
```

Install pkglist packages:

```sh
yay -S $(./pkginstall.sh)
```
Install asdf:

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
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

Install asdf stuff:

```sh
asdf plugin-add crystal
asdf plugin-add nodejs
asdf plugin-add hub
# asdf list-all <name>
asdf install crystal <version>
asdf install nodejs <version>
asdf install hub <version>
asdf global crystal <version>
asdf global nodejs <version>
asdf global hub <version>
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
