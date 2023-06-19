typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

setopt PROMPT_SUBST

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# configure histfile target for zephyr history plugin
HISTFILE=~/.zhistory
# save big history yay
HISTSIZE=290000
SAVEHIST=290000

# use friendlier antidote save names
zstyle ':antidote:bundle' use-friendly-names 'yes'

if ! [[ -e ~/.antidote ]]
then
  git clone https://github.com/mattmc3/antidote.git ~/.antidote
fi
source ~/.antidote/antidote.zsh
antidote load

function zsh_directory_name() {
  emulate -L zsh
  [[ $1 == d ]] || return
  while [[ $2 != / ]]; do
    if [[ -e $2/.git ]]; then
      typeset -ga reply=(${2:t} $#2)
      return
    fi
    2=${2:h}
  done
  return 1
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# autoload -Uz promptinit && promptinit
# prompt powerlevel10k

ZSH_AUTOSUGGEST_MANUAL_REBIND=1  # make prompt faster
DISABLE_MAGIC_FUNCTIONS=true     # make pasting into terminal faster

# zi light-mode for \
#   @fuzzy \
#   @sharkdp

# zi ice as"completion"
# zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# zi ice as"completion"
# zi snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# zi wait lucid for \
        # z-shell/H-S-MW \
        # wfxr/forgit \
        # as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
        #     tj/git-extras

# zi wait lucid pack for ls_colors


# zt_completion(){zi ice lucid ${1/#[0-9][a-c]/wait"${1}"} as"completion" "${@:2}";  }
# zt_completion 0a blockf

# if [ -z "$_zsh_custom_scripts_loaded" ]; then
#     _zsh_custom_scripts_loaded=1

#     zi lucid for wait'1' autoload'#manydots-magic' knu/zsh-manydots-magic
# fi

HISTFILE=~/.zhistory

bindkey '^H' backward-kill-word

removelink() {
  [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}

benchzsh() {
  repeat 20 { time zsh -i -c exit }
}

checkip() {
 curl https://ipapi.co/json/
}

alias p="pnpm"
alias u="ultra --raw --rebuild"
alias sudo="sudo -E"
alias cp="cp -i"         # Confirm before overwriting something
alias free='free -h'                                            # Show sizes in MB
# alias git=hub
alias gs="git status"
alias gc="git commit"
alias font-list="sort <(fc-list : family) | vim -"
alias dc="docker-compose"
alias vim="nvim"
alias vimdiff="nvim -d"
alias clr="printf '\033[2J\033[3J\033[1;1H'"
alias synctime="timedatectl set-ntp true"
alias em="emacs -nw"
alias ex="aunpack"
alias archive="apack -e -F .zip"
# ls memes
alias ls='exa --icons --classify --group-directories-first --time-style=long-iso --group --color-scale'
alias l='ls --git-ignore'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Included options
#
# --recursive          Recurse into directories
# --links              Recreate symlinks
# --perms              Set destination to be the same as the source permissions
# --times              Transfer modification times along with the files (necessary for not duplicating work)
# --owner              (sudo only) Sets destination file owner to the same owner as the source owner, associates by name, may fallback to ID number if no match (modified by --numeric-ids below).
# --update             Skip files that are newer on the receiver (don't overwrite modifications)
# --verbose            Increase verbosity (only one level)
# --one-file-system    Don't cross filesystem boundaries
# --hard-links         Look for hard-linked files in the source and link together corresponding files in the destination
# --whole-file         Disables rsync's delta-transfer. May be faster when bandwidth between source and destination is higher than bandwidth to disk.
# --xattrs             Update the destination extended attributes to be the same as the source ones
# --partial            Keep partial files (maybe doesn't do anything with --whole-file)
# --progress           Print the "progress line" (overall progress)
# --numeric-ids        Use numeric ids rather than name matching for group/user
# --human-readable     Output numbers in a human readable format
# --info=progress2     Use the "progress2" info display
#
# Explicitly excluded notable options
# --specials           Copy extra files
# --devices            Recreate devices files
# --group              Set the group of the dest file to be source file group
alias goodsync="rsync --recursive --links --copy-unsafe-links --perms --times --owner --update --verbose --one-file-system \
                      --hard-links --whole-file --xattrs --partial \
                      --progress --numeric-ids --human-readable --info=progress2"

alias coa="conda deactivate && conda activate"
alias cod="conda deactivate"
alias coc="conda create --name"
alias s="source ~/.zshrc"
alias ys="yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro  yay -S"
alias goodmod="chmod -R u+rwX,go+rX,go-w $@"
alias ssh="TERM=\"xterm-256color\" ssh"
alias lazydocker="TERM=\"xterm-256color\" lazydocker"

alias icat="kitty +kitten icat" # https://sw.kovidgoyal.net/kitty/kittens/icat/

sshforward() {
  ssh $1 -L $2\:localhost\:$2 -N
}

# Get the ip of an ssh destination
sship() {
  ssh -G $1 | awk '/^hostname / { print $2 }'
}

# Forget (remove from known_hosts) an ssh destination
sshforget() {
  ssh-keygen -R $(sship $1)
}

VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

# Handles pager colors
# export LESS="-RFX"
# export LESS_TERMCAP_mb=$(printf "\e[1;31m") \
# export LESS_TERMCAP_md=$(printf "\e[1;31m") \
# export LESS_TERMCAP_me=$(printf "\e[0m") \
# export LESS_TERMCAP_se=$(printf "\e[0m") \
# export LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
# export LESS_TERMCAP_ue=$(printf "\e[0m") \
# export LESS_TERMCAP_us=$(printf "\e[1;32m") \

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--ansi"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export BUN_INSTALL="$HOME/.bun"
export VOLTA_HOME="$HOME/.volta"
export DENO_INSTALL="/home/johnpyp/.deno"

export PATH=/home/johnpyp/.turso:$DENO_INSTALL/bin:$VOLTA_HOME/bin:$BUN_INSTALL/bin:$PATH~/.local/share/pnpm:~/.emacs.d/bin:~/.scripts:~/.luarocks/bin:~/.dotnet/tools:~/go/bin:~/.npm-global/bin:~/.emacs.d/bin:~/.yarn/bin:~/.local/bin:~/.cargo/bin:~/.nimble/bin:/opt/homebrew/bin:$PATH
export XDG_DATA_HOME=$HOME/.local/share

eval $(keychain --eval --quiet id_rsa)
export GO111MODULE="on"

[ -f ~/.profile ] && source ~/.profile
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ "$(command -v bat)" ]; then
  unalias -m 'cat'
  cat() { bat -pp --theme="Nord" $@ }
fi
if [ -e /home/johnpyp/.nix-profile/etc/profile.d/nix.sh ]; then . /home/johnpyp/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/johnpyp/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/johnpyp/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/johnpyp/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/johnpyp/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export CONDA_AUTO_ACTIVATE_BASE=false

# export RUSTC_WRAPPER=sccache

[[ "$(command -v direnv)" ]] && eval "$(direnv hook zsh)"

export DIRENV_LOG_FORMAT=""

# eval $(thefuck --alias)


# 
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/usr/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/johnpyp/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/johnpyp/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/johnpyp/micromamba/etc/profile.d/micromamba.sh"
    else
        export PATH="/home/johnpyp/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [ "$(command -v pyenv)" ]; then
  eval "$(pyenv init --path)"
fi

ZVM_CURSOR_STYLE_ENABLED=false
ZVM_KEYTIMEOUT=0
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
ZVM_ESCAPE_KEYTIMEOUT=0

# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# bun completions
[ -s "/home/johnpyp/.bun/_bun" ] && source "/home/johnpyp/.bun/_bun"

# bun

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

[ -f /opt/mambaforge/etc/profile.d/conda.sh ] && source /opt/mambaforge/etc/profile.d/conda.sh

alias m="micromamba"
alias google-chrome="google-chrome-stable"
