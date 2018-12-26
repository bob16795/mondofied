#!/bin/sh

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

dunst &
jgmenu &
mpd &
#xset r rate 200 50
compton &
feh --bg-fill ~/.config/wall.png
#polybar i3-bar &#"bar.sh &
#exec awesome
exec dwm
#exec i3
