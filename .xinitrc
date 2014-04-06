#!/bin/sh

load_xinitrcd() {
    if test -d ${HOME}/.xinitrc.d
    then
        for f in ${HOME}/.xinitrc.d/*
        do
            if test -f "${f}"
            then
                . "${f}"
            fi
        done
        unset f
    fi
}

# ibus {{{
setup_ibus() {
    export XIM=ibus
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=xim
    export XMODIFIERS=@im=ibus
    export XIM_PROGRAM="ibus-daemon"
    export XIM_ARGS=" --daemonize --xim"
    ibus-daemon -d
    sleep 1
}
# }}}

# uim {{{
setup_uim() {
    export GTK_IM_MODULE='uim'
    export QT_IM_MODULE='uim'
    export XMODIFIERS=@im='uim'
    export UIM_CANDWIN_PROG=uim-candwin-gtk
    uim-xim &
    uim-toolbar-gtk-systray &
}
#}}}


start_apps() {
    # kde
    # export XDG_DATA_DIRS="/usr/local/kde4/share:/usr/local/share/:$XDG_DATA_DIRS"
    export QT_PLUGIN_PATH="/usr/local/kde4/lib/kde4/plugins"

    export PATH="$HOME/local/bin:$PATH"
    export VTE_CJK_WIDTH=auto
    xrdb -merge $HOME/.Xresources
    setxkbmap dvorak
    xmodmap $HOME/.xmodmaprc
    xset b off # turn off beep
    xset r rate 200 40
    xsetroot -cursor_name right_ptr
    # audio volume
    mixer vol 10
    mixer pcm 15
    # urxvtcd &
    xbindkeys &
    #thunar --daemon &
    #spiffy &
    #parcellite &
    #synergys --name $(hostname -s)
    #mpd
    # pulseaudio -D &
}

# if [ "$1" = "twm"  -o "$1" = "flwm" ]; then
#     $HOME/.dzen/bin/status | dzen2 -p -ta l -w 1160 -h 13 -bg gray15 -fn '-*-terminus-medium-r-normal--12-*' -e 'onexit=ungrabmouse' &
#     trayer --expand false --alpha 20  --tint 0x606060 --transparent true --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 7 --widthtype pixel --width 120 &
#     #sleep 20 && wbar -above-desk -bpress -isize 45 -balfa 20 -nanim 9 &
#     if [ -f $HOME/.fehbg ]; then
#         $HOME/.fehbg &
#     else
#         feh --bg-max ~/.wallpaper &
#     fi
#     tint2 &
# fi

start_wm() {
    local wm="${1}"
    local DEFAULT_SESSION="dwm"
    if [ -n ${wm} ]; then
        export USERWM=${wm}
        case ${USERWM} in
            xfce)         exec dbus-launch --exit-with-session ck-launch-session startxfce4 ;;
            fluxbox)      exec dbus-launch --exit-with-session ck-launch-session startfluxbox ;;
            fvwm|fvwm2)   exec dbus-launch --exit-with-session ck-launch-session fvwm2 ;;
            fvwm-themes*) exec dbus-launch --exit-with-session ck-launch-session fvwm-themes-start -s sa ;;
            dwm)          exec dbus-launch --exit-with-session ck-launch-session $HOME/.dwm/startdwm ;;
            kde)          exec dbus-launch --exit-with-session ck-launch-session startkde5 ;;
            gnome)        exec dbus-launch --exit-with-session ck-launch-session gnome-session ;;
            mate)         exec dbus-launch --exit-with-session ck-launch-session mate-session ;;
            rox)          exec dbus-launch --exit-with-session ck-launch-session rox -S ;;
            lainwm)       exec dbus-launch --exit-with-session ck-launch-session lainwm ;;
            openbox)      exec dbus-launch --exit-with-session ck-launch-session openbox-session ;;
            windowmaker)  exec dbus-launch --exit-with-session ck-launch-session wmaker ;;
            mate)         exec dbus-launch --exit-with-session ck-launch-session mate-session ;;
            metisse)      exec dbus-launch --exit-with-session ck-launch-session metisse-start-fvwm ;;
            *)            exec dbus-launch --exit-with-session ck-launch-session $1 ;;
        esac
    else
        exec $DEFAULT_SESSION
    fi
}

sound() {
    local login
    login="${HOME}/.sounds/desktop-login.ogg"
    if test -f ${login}
    then
        play --no-show-progress ${login} &
    fi
}

sound
load_xinitrcd
setup_ibus
add_font_paths
start_apps

start_wm ${1}
