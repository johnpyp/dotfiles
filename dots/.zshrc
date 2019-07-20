source ~/.profile
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

bindkey '^H' backward-kill-word
# [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

#
# ----------------
# Aliases and Helper Functions
# ----------------
#

removelink() {
  [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}
alias ex="unarchive"
alias lsdots="ls -lad ./.*"
alias cp="cp -i"                                                # Confirm before overwriting something
alias free='free -m'                                            # Show sizes in MB
alias git=hub
alias gitu='git add . && git commit && git push'
alias copyghssh="curl https://github.com/johnpyp.keys > ~/.ssh/authorized_keys"
alias dstoprm="docker container stop \$(docker ps -aq) && docker container rm \$(docker ps -aq)"
alias font-list="sort <(fc-list : family) | vim -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias dc="docker-compose"
alias hlib="cd /media/johnpyp/virt/homemedia"
alias vim="nvim"
VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR
export FZF_DEFAULT_COMMAND="fd --type file --follow --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export PATH=~/.yarn/bin:~/.local/bin:$PATH

# NVM Lazy-Loading
# declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
# 
# NODE_GLOBALS+=("node")
# NODE_GLOBALS+=("nvm")
# 
# load_nvm () {
#     export NVM_DIR=~/.nvm
#     [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# }
# 
# for cmd in "${NODE_GLOBALS[@]}"; do
#     eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
# done
# Normal NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# eval "`fnm env --multi`"

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
