#!/bin/sh

indent() {
orig=$1
fish_indent -s < $orig > $(dirname $orig)/tmp_$(basename $orig).fish
}

remove() {
rm $1
}

move() {
tmp=$(dirname $1)/tmp_$(basename $1).fish
mv $tmp $1
}


main() {
indent $1
remove $1
move $1
}

main $1
