setopt promptsubst

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

typeset -g HISTSIZE=290000 SAVEHIST=290000 HISTFILE=~/.zhistory

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"

ZSH_AUTOSUGGEST_MANUAL_REBIND=1  # make prompt faster
DISABLE_MAGIC_FUNCTIONS=true     # make pasting into terminal faster

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

zinit wait lucid for \
        hlissner/zsh-autopair \
        wfxr/forgit \
        zdharma/history-search-multi-word \
        agkozak/zsh-z \
        as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
            tj/git-extras

zinit wait lucid as"null" for \
       node"!fx" zdharma/null

zinit wait lucid pack for ls_colors

zinit wait'0c' lucid for \
         atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
             zdharma/fast-syntax-highlighting \
         atload"_zsh_autosuggest_start" \
             zsh-users/zsh-autosuggestions \
         blockf atpull'zinit creinstall -q .' \
             zsh-users/zsh-completions

if [ -z "$_zsh_custom_scripts_loaded" ]; then
    _zsh_custom_scripts_loaded=1

    zinit lucid for wait'1' autoload'#manydots-magic' knu/zsh-manydots-magic
fi

# autoload -Uz compinit
# compinit
# zinit cdreplay -q

### End of Zinit's installer chunk


command -v lsd > /dev/null && alias ls='lsd --group-dirs first'
# export CONDA_DEFAULT_ENV=""
KEYTIMEOUT=1
bindkey '^H' backward-kill-word
# Enable vim mode
bindkey -v
bindkey -v '^?' backward-delete-char
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

alias sudo="sudo -E"
alias cp="cp -i"         # Confirm before overwriting something
alias free='free -h'                                            # Show sizes in MB
# alias git=hub
alias gs="git status"
alias gc="git commit"
alias copyghssh="curl https://github.com/johnpyp.keys > ~/.ssh/authorized_keys"
alias font-list="sort <(fc-list : family) | vim -"
alias dc="docker-compose"
alias vim="nvim"
alias vimdiff="nvim -d"
alias clr="printf '\033[2J\033[3J\033[1;1H'"
alias synctime="timedatectl set-ntp true"
alias em="emacs -nw"
# alias extract="aunpack"
# alias ex="aunpack"
alias ex="arc unarchive"
alias ex="arc unarchive"
alias archive="apack -e -F .zip"
# ls memes
alias ls='exa --icons --classify --group-directories-first --time-style=long-iso --group --color-scale'
alias l='ls --git-ignore'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias goodsync="rsync -auvxHAWXP --numeric-ids --info=progress2"

alias coa="conda deactivate && conda activate"
alias cod="conda deactivate"
alias coc="conda create --name"
alias s="source ~/.zshrc"
alias ys="yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro  yay -S"

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
export PATH=~/.scripts:~/.luarocks/bin:~/.dotnet/tools:~/go/bin:~/.npm-global/bin:~/.emacs.d/bin:~/.yarn/bin:~/.local/bin:~/.cargo/bin:~/.nimble/bin:$PATH
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

# eval "$(direnv hook zsh)"
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
