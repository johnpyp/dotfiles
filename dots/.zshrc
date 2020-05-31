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

zinit ice lucid wait
zinit snippet OMZ::plugins/extract/extract.plugin.zsh

zinit ice lucid wait atinit"zpcompinit; zpcdreplay"
zinit load "zdharma/fast-syntax-highlighting"

zinit ice lucid wait"1" lucid atload"!_zsh_autosuggest_start"
zinit load "zsh-users/zsh-autosuggestions"

zinit ice lucid wait blockf atpull'zinit creinstall -q .'
zinit load "zsh-users/zsh-completions"

zinit ice lucid wait pick"z.sh"
zinit load "rupa/z"

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

autoload -Uz compinit
compinit
zinit cdreplay

### END PLUGINS

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
# ls memes
alias ls='exa --git --icons --classify --group-directories-first --time-style=long-iso --group --color-scale'
alias l='ls --git-ignore'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR
export TERM=xterm-256color
export SKIM_DEFAULT_COMMAND="fd --color always"
export SKIM_DEFAULT_OPTIONS="--ansi"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--ansi"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export PATH=~/.dotnet/tools:~/go/bin:~/.npm-global/bin:~/.emacs.d/bin:~/.yarn/bin:~/.local/bin:~/.cargo/bin:~/.nimble/bin:$PATH
export XDG_DATA_HOME=$HOME/.local/share

eval $(keychain --eval --quiet id_rsa)
export GO111MODULE="on"
[ -f ~/.profile ] && source ~/.profile

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
