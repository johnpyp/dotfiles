[ -f ~/.profile ] && source ~/.profile
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
KEYTIMEOUT=1
bindkey '^H' backward-kill-word
# [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"

#
# ----------------
# Aliases and Helper Functions
# ----------------
#

removelink() {
  [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}

benchzsh() {
  for i in {1..20}; time zsh -i -c exit
}

alias sudo="sudo -E"
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
export FZF_DEFAULT_COMMAND='rg --smart-case --files --no-ignore --hidden --follow --color always --glob "!.git/*" --glob "!target/*" --glob "!**/node_modules/*"'
export FZF_DEFAULT_OPTS="--ansi"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export PATH=~/.yarn/bin:~/.local/bin:$PATH

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
