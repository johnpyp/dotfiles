dotfiles=(".zshrc" ".gitconfig" ".Xresources" ".vimrc" ".ripgreprc" ".ideavimrc" ".vpn")
config_dotdirectories=("i3" "polybar" "pscripts" "networkmanager-dmenu" "wallpapers" "nvim" "kitty" "redshift.conf" "starship.toml")

mkdir -p backups
for dotfile in "${dotfiles[@]}"
do
  if [ -e ${PWD}/dots/${dotfile} ]; then
    if [ ! "`readlink ${HOME}/${dotfile}`" -ef "${PWD}/dots/${dotfile}" ]; then
      if [ -e ${HOME}/${dotfile} ]; then
        mv ${HOME}/${dotfile} ${PWD}/backups
      fi
      ln -sv "${PWD}/dots/${dotfile}" ${HOME}
    fi
  fi
done

for config_dotfile in "${config_dotdirectories[@]}"
do
  if [ -e ${PWD}/dots/${config_dotfile} ]; then
    if [ ! "`readlink ${HOME}/.config/${config_dotfile}`" -ef "${PWD}/dots/${config_dotfile}" ]; then
      if [ -e ${HOME}/.config/${config_dotfile} ]; then
        mv ${HOME}/.config/${config_dotfile} ${PWD}/backups
      fi
      ln -sv "${PWD}/dots/${config_dotfile}" ${HOME}/.config/${config_dotfile}
    fi
  fi
done
