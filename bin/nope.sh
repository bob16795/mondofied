
set -e
rm lol.png
pscircle \
	--background-image=~/wall.png \
	--root-pid=1 \
	--collapse-threads=true \
	--max-children=350 \
	--tree-sector-angle=3.1415 \
	--tree-rotate=true \
	--tree-rotation-angle=1.5708 \
	--tree-center=-1580:0 \
	--cpulist-center=300:0 \
	--memlist-center=800:0 \
	--output-width=1440 \
	--output-height=900 \
	--output=lol.png
