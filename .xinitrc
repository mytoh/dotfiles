#!/bin/sh

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
setup_ibus
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
add_font_paths() {
    xset +fp /usr/local/lib/X11/fonts/artwiz-aleczapka-en
    xset +fp /usr/local/lib/X11/fonts/artwiz-fonts
    xset +fp /usr/local/lib/X11/fonts/artwiz-ru
    xset +fp /usr/local/lib/X11/fonts/misc
    xset +fp /usr/local/lib/X11/fonts/webfonts
    xset +fp /usr/local/lib/X11/fonts/Droid
    xset +fp /usr/local/lib/X11/fonts/Myanmar
    xset +fp /usr/local/lib/X11/fonts/URW
    xset +fp /usr/local/lib/X11/fonts/suxus
    xset +fp /usr/local/lib/X11/fonts/std.ja_JP
    xset +fp /usr/local/lib/X11/fonts/amsfonts
    xset +fp /usr/local/lib/X11/fonts/cantarell
    xset +fp /usr/local/lib/X11/fonts/mplus
    xset +fp /usr/local/lib/X11/fonts/shinonome
    xset +fp /usr/local/lib/X11/fonts/proggy_fonts-ttf
    xset +fp /usr/local/lib/X11/fonts/bitstream-vera
    xset +fp /usr/local/lib/X11/fonts/cyrillic
    xset +fp /usr/local/lib/X11/fonts/dejavu
    xset +fp /usr/local/lib/X11/fonts/jisx0213
    xset +fp /usr/local/lib/X11/fonts/jmk
    xset +fp /usr/local/lib/X11/fonts/local
    xset +fp /usr/local/lib/X11/fonts/SourceCodePro
    xset +fp /usr/local/lib/X11/fonts/anonymous-pro
    xset +fp /usr/local/lib/X11/fonts/GentiumPlus
    xset +fp /usr/local/lib/X11/fonts/terminus-font
    xset +fp /usr/local/lib/X11/fonts/SourceCodePro
    xset +fp /usr/local/lib/X11/fonts/Roboto

    xset +fp $HOME/.fonts
    xset fp rehash
}
add_font_paths

start_apps() {
    # audio volume
    mixer vol 10
    mixer pcm 15
    # urxvtcd &
    xbindkeys &
    thunar --daemon &
    #spiffy &
    #parcellite &
    #synergys --name $(hostname -s)
    #mpd
    pulseaudio -D &
}
start_apps

if [ "$1" = "twm"  -o "$1" = "flwm" ]; then
    $HOME/.dzen/bin/status | dzen2 -p -ta l -w 1160 -h 13 -bg gray15 -fn '-*-terminus-medium-r-normal--12-*' -e 'onexit=ungrabmouse' &
    trayer --expand false --alpha 20  --tint 0x606060 --transparent true --padding 1 --margin 0 --edge top --align right --SetDockType true --SetPartialStrut true --heighttype pixel --height 7 --widthtype pixel --width 120 &
    #sleep 20 && wbar -above-desk -bpress -isize 45 -balfa 20 -nanim 9 &
    if [ -f $HOME/.fehbg ]; then
        $HOME/.fehbg &
    else
        feh --bg-max ~/.wallpaper &
    fi
    tint2 &
fi

start_wm() {
    local wm="${1}"
    local DEFAULT_SESSION="dwm"
    if [ -n ${wm} ]; then
        export USERWM=${wm}
        case ${USERWM} in
            xfce)         exec dbus-launch ck-launch-session startxfce4 ;;
            fluxbox)      exec dbus-launch startfluxbox ;;
            fvwm|fvwm2)   exec dbus-launch fvwm2 ;;
            fvwm-themes*) exec dbus-launch fvwm-themes-start -s sa ;;
            dwm)          exec dbus-launch $HOME/.dwm/startdwm ;;
            kde)          exec dbus-launch startkde4 ;;
            gnome)        exec dbus-launch gnome-session ;;
            mate)         exec dbus-launch ck-launch-session mate-session ;;
            rox)          exec dbus-launch rox -S ;;
            lainwm)       exec dbus-launch lainwm ;;
            openbox)  exec openbox-session ;;
            *)            exec dbus-launch --exit-with-session ck-launch-session $1 ;;
        esac
    else
        exec $DEFAULT_SESSION
    fi
}

start_wm ${1}
