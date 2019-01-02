while true;
do
	xsetroot -name "$(upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "percentage"| sed 's/    percentage:          //')"
	#[ -f /dev/mmcblk0 ] && echo "lol" || echo "nope"
	sleep .1
done
