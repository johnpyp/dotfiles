[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

export GTK_USE_PORTAL=1
export XDG_CURRENT_DESKTOP=KDE
export KDE_SESSION_VERSION=5
export QT_AUTO_SCREEN_SCALE_FACTOR=0 

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
