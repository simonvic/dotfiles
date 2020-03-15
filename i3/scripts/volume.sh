#!/bin/bash

#	Increase the volume by x%
increaseAmount=1

#	With drawBox = true
#	┌────────────────────┐
#	│████████████▃░░░░░░░│ 62%
#	└────────────────────┘

#	With drawBox = false
#	████████████▃░░░░░░░ 62%
drawBox=false

#	Default icon
icon=audio-volume-medium

#	Default urgency level [Available: low, normal, critical]
urgency=normal

#	At which level the volume is considered too high
warningLevel=60

#	For how much milliseconds the notification will stay visible
timeout=1500

#	Unique dunst notification id
uid=2593


line=$(seq -s "─" 0 5 100 | sed 's/[0-9]//g')



function getVolume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function isMute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function sendNotification {
    volume=`getVolume`

	# Building the volume bar
	# TO-DO make colored warning bar
    bar=$(seq -s "█" 0 5 $volume | sed 's/[0-9]//g') 
	if [ $(( ($volume-4) % 5 )) -eq 0 ]; then
		midBar=▆
	elif [ $(( ($volume-3) % 5 )) -eq 0 ]; then
		midBar=▅
	elif [ $(( ($volume-2) % 5 )) -eq 0 ]; then
		midBar=▃
	elif [ $(( ($volume-1) % 5 )) -eq 0 ]; then
		midBar=▁
	fi
    emptyBar=$(seq -s "░" $(( ((100-$volume) /5)+1 )) | sed 's/[0-9]//g')
   
   	if [ $drawBox = true ]; then
 	 body="┌$line┐\n│$bar$midBar$emptyBar│\t<b>$volume%</b>\n└$line┘"	 
	else
	 body="$bar$midBar$emptyBar\t<b>$volume%</b>"
 	fi

	if [ $volume -ge $warningLevel ]; then
  		urgency=critical
  		icon=audio-volume-high
  	fi
  	
    # Send the notification
    dunstify -a "Volume" -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$volume" "$body"
    
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master "$increaseAmount"%+ > /dev/null
	sendNotification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master "$increaseAmount"%- > /dev/null
	sendNotification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if isMute ; then
		emptyBar=$(seq -s "░" $((100/5 +1)) | sed 's/[0-9]//g')
		
		if [ $drawBox = true ]; then
			body="┌$line┐\n│$emptyBar│\t<b>Muted</b>\n└$line┘"
		else
			body="$emptyBar\t<b>Muted</b>"
		fi
		dunstify -a "Volume" -i audio-volume-low -t "$timeout" -r "$uid" -u "$urgency" "Muted" "$body"
	else
	    sendNotification
	fi
	;;
esac
