while true;
do
	xsetroot -name "$(i3mpd) | $(i3battery BAT0) | $(i3mem) | $(i3pacman) | $(i3disk /) | $(i3internet) | $(i3mail)"
    sleep 1
done
