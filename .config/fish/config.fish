
set fish_greeting "><>"
echo fuuuuuuuuuuuuuuuuuuuuuck

## shellar
set -gx shellar ~/.shellar
## plugins
set -gx shellar_plugins mytoh freebsd loitsu lehti nopea talikko emacs napa pikkukivi brew lol radio mosh
## theme
set -gx shellar_theme default
## custom
set -gx shellar_custom ~/.shellar_custom
## debug
#set -gx shellar_debug
# source shellar
source {$shellar}/shellar/shellar.fish

shellar.init

# memo
# redirect
#  func 2> /dev/null
#  func ^/dev/null
#  func ^&-

# vim: foldmethod=marker
# 🐟  \U1f41f
# ➤   \U27A4
