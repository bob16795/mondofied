#!/bin/bash

sh ~/scr/wall.sh
killall -HUP dwm
pkill -RTMIN+9 dwmblocks
killall dunst
dunst &
