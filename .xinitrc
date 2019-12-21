#!/bin/sh

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

sh ~/.screen.sh
dunst & #notifications
jgmenu --hide-on-startup & #menu
mpd & #music
#spotify & #music
bar &
xset r rate 300 50 #key repeate
compton -Cc& #composite
#feh --bg-fill ~/.config/wall.png # wallpaper old
~/scr/wall.sh & # wallpaper
mpd-notification &
# firefox & #web
#qutebrowser file:///home/john/.config/webhome/index.html &
#dockd --daemon & #dock
#glava & # music vis
#alacritty --class dev & #dev
alacritty --class visual -e vis& #music vis
#steam & #game
#discord & #chat
torify dropbox &

#exec alacritty
exec dwm
