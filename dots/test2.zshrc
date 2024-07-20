typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

setopt PROMPT_SUBST


# zstyle ':prezto:module:history' histfile "<file_name>"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# use friendlier antidote save names
zstyle ':antidote:bundle' use-friendly-names 'yes'

if ! [[ -e ~/.antidote ]]
then
  git clone https://github.com/mattmc3/antidote.git ~/.antidote
fi

source ~/.antidote/antidote.zsh
antidote load

setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing non-existent history.

HISTFILE=~/.zsh_history
# save a lot of history
HISTSIZE=290000
SAVEHIST=290000


if [ -z "$_zsh_custom_scripts_loaded" ]; then
    _zsh_custom_scripts_loaded=1

    # knu/zsh-manydots-magic
    autoload -Uz manydots-magic
    manydots-magic
fi

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

ZSH_AUTOSUGGEST_MANUAL_REBIND=1  # make prompt faster
DISABLE_MAGIC_FUNCTIONS=true     # make pasting into terminal faster

bindkey '^H' backward-kill-word

removelink() {
  [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}

benchzsh() {
  repeat 20 { time zsh -i -c exit }
}

alias b="bun"
alias p="pnpm"
alias dc="docker-compose"
alias vim="nvim"

alias sudo="sudo -E "
alias cp="cp -i"         # Confirm before overwriting something
alias ex="ouch d -q"     # Extract an archive
alias s="source $HOME/.zshrc"

alias font-list="sort <(fc-list : family) | vim -"
alias vimdiff="nvim -d"

alias clr="printf '\033[2J\033[3J\033[1;1H'"
alias synctime="timedatectl set-ntp true"

# extra ls commands
alias ls='eza --icons --classify --group-directories-first --time-style=long-iso --group --color-scale all'
alias l='ls --git-ignore'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'


#### A better rsync default
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
alias goodsync="rsync --recursive --links --perms --times --owner --update --verbose --one-file-system \
                      --hard-links --whole-file --xattrs --partial \
                      --progress --numeric-ids --human-readable --info=progress2"

### A better chmod default, properly setting permission flags for the current user
alias goodmod="chmod -R u+rwX,go+rX,go-w $@"

if [ "$(command -v bat)" ]; then
  unalias -m 'cat'
  cat() { bat -pp --theme="Nord" $@ }
fi

# turn on if you run into ssh display issues
# alias ssh="TERM=\"xterm-256color\" ssh"

# Forward a port from remote ssh to local
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

# Use neovim for editor stuff
export VISUAL=nvim;
export EDITOR=nvim;

# Automatic refresh of powerlevel10k git status
# https://github.com/romkatv/gitstatus/issues/368#issuecomment-1387269889
# maybe causes a bug with completions?
TRAPALRM() {
  local f
  for f in chpwd "${chpwd_functions[@]}" precmd "${precmd_functions[@]}"; do
    [[ "${+functions[$f]}" == 0 ]] || "$f" &>/dev/null || true
  done
  p10k display -r
}

# Invoke TRAPALRM every 30 seconds.
TMOUT=30

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--ansi"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export BUN_INSTALL="$HOME/.bun"
export DENO_INSTALL="$HOME/.deno"

export PATH=$DENO_INSTALL/bin:$BUN_INSTALL/bin:~/.scripts:~/.luarocks/bin:~/go/bin:~/.local/bin:~/.cargo/bin:/opt/homebrew/bin:$PATH
# export XDG_DATA_HOME=$HOME/.local/share

export GO111MODULE="on"

[ -f $HOME/.profile ] && source ~/.profile
[ -f $HOME/.fzf.zsh ] && source ~/.fzf.zsh

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Use good en_US presets for LC stuff
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

[[ -f $HOME/.kube/clusters ]] && export KUBECONFIG=$(find $HOME/.kube/clusters -type f | sed ':a;N;s/\n/:/;ba') || true

alias m="micromamba"
alias b="bun"

[[ -f $HOME/.kube/clusters ]] && export KUBECONFIG=$(find ~/.kube/clusters -type f | sed ':a;N;s/\n/:/;ba') || true
[[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" || true

command -v mise && eval "$(mise activate zsh)" || true
command -v keychain && eval $(keychain --eval --quiet id_rsa) || true

[[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" || true

# ZSH VIM plugin (ZVM) configuration
ZVM_CURSOR_STYLE_ENABLED=false
ZVM_KEYTIMEOUT=0
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
ZVM_ESCAPE_KEYTIMEOUT=0
