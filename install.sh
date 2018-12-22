dotfiles=(".zshrc" ".gitconfig", ".zpreztorc")

mkdir -p backups
for dotfile in "${dotfiles[@]}"
do
  if [ -f ./${dotfile} ]; then
    if [ ! "`readlink ${HOME}/${dotfile}`" -ef "${PWD}/${dotfile}" ]; then
      if [ -f ${HOME}/${dotfile} ]; then
        mv -f ${HOME}/${dotfile} ${PWD}/backups
      fi
      ln -sv "${PWD}/${dotfile}" ${HOME}
    fi
  fi

done
