  #!/bin/bash

if pgrep -x "cmus" > /dev/null
then
	status=$( cmus-remote -Q | grep status\ | sed 's/status //' )
	if [[ "$status" = *playing*  ]]
	then
		echo -ne " %{F#70a070}p "
	elif [[ "$status" = *paused* ]]
	then
		echo -ne " %{F#70a070}= "
	elif [[ "$status" = *stopped* ]]
	then
		echo -ne " %{F#70a070}x "
	fi
else
	echo -ne " ? "
fi
