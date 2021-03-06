#!/usr/bin/env bash

reset=$1
current="$(setxkbmap -query | grep layout | perl -pe 's/^layout: +([^ ]+)$/$1/')"

if [ "$reset" != "" ] || [ "$current" != "us" ]; then
  setxkbmap -layout "us"
else
  setxkbmap -layout "ru"
fi

# Enable digraphs
setxkbmap -option compose:ralt

# Refresh py3status immediately
py3-cmd refresh keyboard_layout
