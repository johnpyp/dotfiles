### BEGIN PLUGINS
if [ ! -e ~/.zinit ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  sleep 2
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit snippet OMZ::lib/history.zsh

zinit ice lucid wait
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit light zinit-zsh/z-a-bin-gem-node

zinit wait lucid light-mode for \
        atinit"zicompinit; zicdreplay" \
            zdharma/fast-syntax-highlighting \
        atload"_zsh_autosuggest_start" \
            zsh-users/zsh-autosuggestions \
        blockf atpull'zinit creinstall -q .' \
            zsh-users/zsh-completions

zinit wait lucid light-mode for \
        "kutsan/zsh-system-clipboard" \
        "hlissner/zsh-autopair" \
        "wfxr/forgit" \
        "zdharma/history-search-multi-word" \
        "agkozak/zsh-z"

zinit wait"1" lucid from"gh-r" as"null" for \
        sbin"fzf"          junegunn/fzf-bin \
        sbin"**/fd"        @sharkdp/fd \
        sbin"**/bat"       @sharkdp/bat \
        sbin"**/rg"        BurntSushi/ripgrep \
        sbin"exa* -> exa"  ogham/exa \
        sbin"jq* -> jq" ver="jq-1.6" bpick="*linux64*"  stedolan/jq

zinit wait"2" lucid as"null" for \
        node"!fx" zdharma/null \

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

autoload -Uz compinit
compinit
zinit cdreplay

### END PLUGINS

export CONDA_DEFAULT_ENV=""
KEYTIMEOUT=1
bindkey '^H' backward-kill-word
# Enable vim mode
bindkey -v
bindkey -v '^?' backward-delete-char
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
alias ssh="TERM=xterm-256color ssh"
alias archive="tar -zcvf"
alias cp="cp -i"         # Confirm before overwriting something
alias free='free -h'                                            # Show sizes in MB
alias git=hub
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
alias extract="aunpack"
alias ex="aunpack"
# ls memes
alias ls='exa --icons --classify --group-directories-first --time-style=long-iso --group --color-scale'
alias l='ls --git-ignore'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--ansi"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export PATH=~/.dotnet/tools:~/go/bin:~/.npm-global/bin:~/.emacs.d/bin:~/.yarn/bin:~/.local/bin:~/.cargo/bin:~/.nimble/bin:$PATH
export XDG_DATA_HOME=$HOME/.local/share

eval $(keychain --eval --quiet id_rsa)
export GO111MODULE="on"

[ -f ~/.profile ] && source ~/.profile
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#eval "$(starship init zsh)"

if [ "$(command -v bat)" ]; then
  unalias -m 'cat'
  alias cat='bat -pp --theme="Nord"'
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
