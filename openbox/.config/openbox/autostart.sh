
# tint2 &

if test -d ~/huone/kuvat/sivusto/4chan/a
then
    feh --randomize --bg-fill --recursive ~/huone/kuvat/sivusto/4chan/a &
else
    if test -f ~/.fehbg
    then

        sh ~/.fehbg &
    fi

fi

openbox-menu -p -o menu.xml &
