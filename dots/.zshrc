setopt promptsubst

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# # Remove older duplicate entries from history.
# setopt hist_ignore_all_dups
# # Expire A Duplicate Event First When Trimming History.
# setopt hist_expire_dups_first
# # Do Not Record An Event That Was Just Recorded Again.
# setopt hist_ignore_dups  
# # Remove superfluous blanks from history items.       
# setopt hist_reduce_blanks
# # Do Not Display A Previously Found Event.
# setopt hist_find_no_dups
# # Do Not Record An Event Starting With A Space.
# setopt hist_ignore_space
# # Do Not Write A Duplicate Event To The History File.
# setopt hist_save_no_dups
# # Do Not Execute Immediately Upon History Expansion.        
# setopt hist_verify

# Allow multiple sessions append to one zsh command history.           
setopt append_history
# Show Timestamp In History.
setopt extended_history
# Write to history file immediately, not after shell exit.
setopt inc_append_history
# Share history between different instances of the shell.
setopt share_history    

typeset -g HISTSIZE=290000 SAVEHIST=290000 HISTFILE=~/.zhistory

### Added by Zi's installer
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}z-shell/zi%F{220})…%f"
    command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
    command git clone https://github.com/z-shell/zi.git "$HOME/.zi/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"


ZSH_AUTOSUGGEST_MANUAL_REBIND=1  # make prompt faster
DISABLE_MAGIC_FUNCTIONS=true     # make pasting into terminal faster

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zi ice lucid
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes+rec

zi ice depth=1; zi light romkatv/powerlevel10k

zi light-mode for \
  @fuzzy \
  @sharkdp

zi wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zi creinstall -q .' \
    zsh-users/zsh-completions

# zi as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
#     atpull'%atclone' pick"direnv" src"zhook.zsh" for \
#         direnv/direnv
#
zi ice as"completion"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi ice as"completion"
zi snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

zi wait lucid for \
        hlissner/zsh-autopair \
        z-shell/H-S-MW \
        wfxr/forgit \
        agkozak/zsh-z \
        as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
            tj/git-extras

# zi wait lucid as"null" for \
#        node"!fx" zdharma/null

zi wait lucid pack for ls_colors


# zt_completion(){zi ice lucid ${1/#[0-9][a-c]/wait"${1}"} as"completion" "${@:2}";  }
# zt_completion 0a blockf

if [ -z "$_zsh_custom_scripts_loaded" ]; then
    _zsh_custom_scripts_loaded=1

    zi lucid for wait'1' autoload'#manydots-magic' knu/zsh-manydots-magic
fi
# Next two lines must be below the above two
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

### End of zi's installer chunk

# export CONDA_DEFAULT_ENV=""
KEYTIMEOUT=1
bindkey '^H' backward-kill-word
# Enable vim mode
# bindkey -v '^?' backward-delete-char
# bindkey -s '\e[1;2Q' ''
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
alias goodsync="rsync -rlptoD -uvxHWXP --numeric-ids --info=progress2"

alias coa="conda deactivate && conda activate"
alias cod="conda deactivate"
alias coc="conda create --name"
alias s="source ~/.zshrc"
alias ys="yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro  yay -S"
alias goodmod="chmod -R u+rwX,go+rX,go-w $@"
alias ssh="TERM=\"xterm-256color\" ssh"

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

export LESS="-RFX"
export LESS_TERMCAP_mb=$(printf "\e[1;31m") \
export LESS_TERMCAP_md=$(printf "\e[1;31m") \
export LESS_TERMCAP_me=$(printf "\e[0m") \
export LESS_TERMCAP_se=$(printf "\e[0m") \
export LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
export LESS_TERMCAP_ue=$(printf "\e[0m") \
export LESS_TERMCAP_us=$(printf "\e[1;32m") \

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--ansi"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export PATH=~/.emacs.d/bin:~/.scripts:~/.luarocks/bin:~/.dotnet/tools:~/go/bin:~/.npm-global/bin:~/.emacs.d/bin:~/.yarn/bin:~/.local/bin:~/.cargo/bin:~/.nimble/bin:/opt/homebrew/bin:$PATH
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
# export TERM="kitty"

# eval "$(starship init zsh)"

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
# eval $(thefuck --alias)


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/usr/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/johnpyp/micromamba";
__mamba_setup="$('/usr/bin/micromamba' shell hook --shell zsh --prefix '/home/johnpyp/micromamba' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/johnpyp/micromamba/etc/profile.d/mamba.sh" ]; then
        . "/home/johnpyp/micromamba/etc/profile.d/mamba.sh"
    else
        export PATH="/home/johnpyp/micromamba/bin:$PATH"
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

alias m="micromamba"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
