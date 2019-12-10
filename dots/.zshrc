### BEGIN PLUGINS
if [ ! -e ~/.zplugin ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
  sleep 2
fi

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin


zplugin snippet OMZ::lib/history.zsh
zplugin ice lucid wait
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zplugin ice lucid wait
zplugin snippet OMZ::plugins/extract/extract.plugin.zsh
# Autosuggestions & fast-syntax-highlighting
zplugin ice lucid wait atinit"zpcompinit; zpcdreplay"
zplugin light "zdharma/fast-syntax-highlighting"
# zsh-autosuggestions
zplugin ice lucid wait"1" lucid atload"!_zsh_autosuggest_start"
zplugin load "zsh-users/zsh-autosuggestions"
# Pure Theme
zplugin ice lucid pick"async.zsh" src"pure.zsh"
zplugin light "sindresorhus/pure"

# Zsh completions
zplugin ice lucid wait blockf atpull'zplugin creinstall -q .'
zplugin light "zsh-users/zsh-completions"

# ls
zplugin ice lucid wait
zplugin load "zpm-zsh/ls"

zplugin ice lucid wait"1"
zplugin load "changyuheng/fz"

zplugin ice lucid wait pick"z.sh"
zplugin load "rupa/z"

zplugin ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zplugin light trapd00r/LS_COLORS

autoload -Uz compinit
compinit
zplugin cdreplay

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
  for i in {1..20}; time zsh -i -c exit
}

alias sudo="sudo -E"
alias archive="tar -zcvf"
alias cp="cp -i"         # Confirm before overwriting something
alias free='free -h'                                            # Show sizes in MB
alias git=hub
alias copyghssh="curl https://github.com/johnpyp.keys > ~/.ssh/authorized_keys"
alias font-list="sort <(fc-list : family) | vim -"
alias dc="docker-compose"
alias vim="nvim"
alias vimdiff="nvim -d"
alias clearr="printf '\033[2J\033[3J\033[1;1H'"
alias synctime="timedatectl set-ntp true"
alias em="emacs -nw"
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
# alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

# export FZF_DEFAULT_COMMAND='rg --smart-case --files --no-ignore --hidden --follow --color always --glob "!.git/*" --glob "!**/target/*" --glob "!**/node_modules/*"'
export FZF_DEFAULT_COMMAND='fd -H -I --type f --exclude "**/target/*" --exclude "**/node_modules/*" --exclude ".git/*" --exclude ".idea/*" --exclude "**/build/*"'
export FZF_DEFAULT_OPTS="--ansi"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export PATH=~/go/bin:~/.npm-global/bin:~/.emacs.d/bin:~/.yarn/bin:~/.local/bin:$PATH

eval $(keychain --eval --quiet id_rsa)
export GO111MODULE="on"
[ -f ~/.profile ] && source ~/.profile

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fasd --init auto)"
