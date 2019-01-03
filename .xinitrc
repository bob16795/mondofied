#!/bin/sh

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

dunst &
jgmenu &
mpd &
#spotify &
#bar.sh &
#xset r rate 200 50
compton &
#feh --bg-fill ~/.config/wall.png
#polybar i3-bar &
bar.sh &
#alacritty &
firefox &
dockd --daemon &
#glava &
alacritty --class visual -e vis &
steam &
~/scr/wall.sh &
sublime &
#exec awesome
exec dwm
#exec i3
