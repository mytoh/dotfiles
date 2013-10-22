#!/bin/sh

exec wmctrl -r "${1}" -b toggle,above
