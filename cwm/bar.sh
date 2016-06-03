#!/bin/sh

## http://blog.z3bra.org/2014/04/meeting-at-the-bar.html

TOTAL_DESKTOPS=$(xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}')

groups() {
    cur=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
    cw="^fg(#ffaaaa)*^fg()"

    if test ${cur} -eq 1
    then
        line="${cw}"
        for w in $(seq 2 ${TOTAL_DESKTOPS})
        do
            line="${line}="
        done
        echo $line
    else

        # Desktop numbers start at 0. if you want desktop 2 to be in second place,
        # start counting from 1 instead of 0. But wou'll lose a group ;)
        for w in $(seq 1 $((cur - 1)))
        do
            line="${line}="
        done

        # enough =, let's print the current desktop
        line="${line}${cw}"
        # En then the other groups
        for w in $(seq $((cur + 1)) ${TOTAL_DESKTOPS})
        do
            line="${line}="
        done

        # don't forget to print that line!
        echo $line
    fi

}

# This loop will fill a buffer with our infos, and output it to stdout.
while :; do
    buf=""
    buf="${buf} [$(groups)]   --  "
    dt="$(date)"

    echo $buf ${dt}
    # use `nowplaying scroll` to get a scrolling output!
    sleep 1 # The HUD will be updated every second
done | dzen2 -p -ta l -h 12 -bg gray15 -fn '-misc-fixed-medium-r-normal--10-*-75-75-c-*-*-*' -e 'onexit=ungrabmouse'
# done | dzen2 -p -ta l -h 12 -bg gray15 -fn 'Bitstream Vera Sans-12' -e 'onexit=ungrabmouse'
