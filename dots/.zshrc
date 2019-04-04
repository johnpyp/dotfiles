
# Installing Prezto: git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
prompt pure

#
# ----------------
# Normal Initilization Stuff
# ----------------
#
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

#
# ----------------
# Aliases and Helper Functions
# ----------------
#
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
removelink() {
  [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}
alias lsdots="ls -lad ./.*"
alias cp="cp -i"                                                # Confirm before overwriting something
alias free='free -m'                                            # Show sizes in MB
alias git=hub
alias gitu='git add . && git commit && git push'
alias copyghssh="curl https://github.com/johnpyp.keys > ~/.ssh/authorized_keys"
alias dstoprm="docker container stop \$(docker ps -aq) && docker container rm \$(docker ps -aq)"
alias font-list="sort <(fc-list : family) | vim -"

VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR
export FZF_DEFAULT_COMMAND="fd --type file --follow --color=always"
export FZF_DEFAULT_OPTS="--ansi"

# NVM Lazy-Loading
declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")

load_nvm () {
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
done
