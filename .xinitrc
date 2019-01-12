#!/bin/sh

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

dunst & #notifications
jgmenu & #menu
mpd & #music
#spotify & #music
#bar & # status
slstatus & # status
#xset r rate 300 50 #key repeate
compton & #composite
#feh --bg-fill ~/.config/wall.png # wallpaper old
~/scr/wall.sh & # wallpaper
#alacritty --class lin & # terminal
firefox & #web
#qutebrowser file:///home/john/.config/webhome/index.html &
dockd --daemon & #dock
#glava & # music vis
alacritty --class dev & #dev
alacritty --class visual -e vis & #music vis
steam & #game
#sublime & #dev
#cairo-dock &
torify dropbox &

exec dwm
