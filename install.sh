dotfiles=(".zshrc" ".gitconfig" ".zpreztorc")

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
