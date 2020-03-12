#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

#▁ ▂ ▃ ▄ ▅ ▆ ▇ █

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
	 if [ $(( ($volume-4) % 5 )) -eq 0 ]; then
	 		midBar=▆
	 	elif [ $(( ($volume-3) % 5 )) -eq 0 ]; then
			midBar=▅
	 	elif [ $(( ($volume-2) % 5 )) -eq 0 ]; then
			midBar=▃
	 	elif [ $(( ($volume-1) % 5 )) -eq 0 ]; then
			midBar=▁
	 fi
    bar=$(seq -s "█" 0 5 $volume | sed 's/[0-9]//g'  )
    emptyBar=$(seq -s "░" $(( ((100-$volume) /5)+1 )) | sed 's/[0-9]//g'  )
    # Send the notification
    dunstify -a "Volume" -i audio-volume-high -t 1000 -r 2593 -u normal "$volume%" "$bar$midBar$emptyBar"
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D pulse sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 5%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
		emptyBar=$(seq -s "░" $((100/5 +1)) | sed 's/[0-9]//g'  )
		dunstify -a "Volume" -i audio-volume-low -t 1000 -r 2593 -u normal "Muted" "$emptyBar"
	else
	    send_notification
	fi
	;;
esac
