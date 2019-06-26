dotfiles=(".zshrc" ".gitconfig" ".zpreztorc" ".Xresources" ".vimrc")
config_dotdirectories=("i3" "polybar" "pscripts" "networkmanager-dmenu" "wallpapers" "nvim" "alacritty")

mkdir -p backups
for dotfile in "${dotfiles[@]}"
do
  if [ -f ${PWD}/dots/${dotfile} ]; then
    if [ ! "`readlink ${HOME}/${dotfile}`" -ef "${PWD}/dots/${dotfile}" ]; then
      if [ -f ${HOME}/${dotfile} ]; then
        mv -f ${HOME}/${dotfile} ${PWD}/backups
      fi
      ln -sv "${PWD}/dots/${dotfile}" ${HOME}
    fi
  fi
done

for config_dotfile in "${config_dotdirectories[@]}"
do
  if [ -d ${PWD}/dots/${config_dotfile} ]; then
    if [ ! "`readlink ${HOME}/.config/${config_dotfile}`" -ef "${PWD}/dots/${config_dotfile}" ]; then
      if [ -d ${HOME}/.config/${config_dotfile} ]; then
        mv ${HOME}/.config/${config_dotfile} ${PWD}/backups
      fi
      ln -sv "${PWD}/dots/${config_dotfile}" ${HOME}/.config/${config_dotfile}
    fi
  fi
done

