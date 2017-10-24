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
    # uim-toolbar-qt4 &
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
    # xset r rate 200 60
    xsetroot -cursor_name right_ptr
    # audio volume
    mixer vol 10
    mixer pcm 10
    # urxvtcd &
    dunst &
    #thunar --daemon &
    #spiffy &
    #parcellite &
    #synergys --name $(hostname -s)
    ##musicpd
    # pulseaudio -D &
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

# setup_uim
add_font_paths
start_apps

start_wm ${1}
