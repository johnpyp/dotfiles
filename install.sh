dotfiles=(".zshrc" ".gitconfig")
for dotfile in "${dotfiles[@]}"
do
  if [ -f ./${dotfile} ]; then
    ln -sv "${PWD}/${dotfile}" ~
    echo "${dotfile} found."
  fi

done
