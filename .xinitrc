#!/bin/sh

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

dunst &
jgmenu &
mpd &
#bar.sh &
#xset r rate 200 50
compton &
#feh --bg-fill ~/.config/wall.png
feh --bg-scale ~/.config/left.png ~/.config/right.png
#polybar i3-bar &#"bar.sh &
alacritty &
firefox &
dockd --daemon &
glava &

#exec awesome
exec dwm
#exec i3
