
set fish_greeting "🐟"


# shellar
set -gx shellar ~/.shellar
# plugins
set -gx shellar_plugins mytoh freebsd loitsu lehti nopea talikko emacs napa pikkukivi brew lol radio mosh
# theme
set -gx shellar_theme default
# custom
set -gx shellar_custom ~/.shellar_custom
# source shellar
source {$shellar}/shellar/shellar.fish

# memo
# redirect
#  func 2> /dev/null
#  func ^/dev/null
#  func ^&-

# vim: foldmethod=marker
# 🐟  \U1f41f

