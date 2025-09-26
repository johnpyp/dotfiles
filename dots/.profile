# [ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

export GTK_USE_PORTAL=1
# export XDG_CURRENT_DESKTOP=sway
# export KDE_SESSION_VERSION=5
# export QT_AUTO_SCREEN_SCALE_FACTOR=0
# export QT_QPA_PLATFORMTHEME=qt5ct

# flameshot support: https://github.com/flameshot-org/flameshot/blob/master/docs/Sway%20and%20wlroots%20support.md
export SDL_VIDEODRIVER=wayland,x11
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
# export XDG_CURRENT_DESKTOP=sway
## END flameshot support

if [ -n "$DESKTOP_SESSION" ]; then
  # eval $(gnome-keyring-daemon --start)
  export SSH_AUTH_SOCK
fi
# . "/home/johnpyp/.deno/env"
# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/johnpyp/.lmstudio/bin"

. "$HOME/.grit/bin/env"
