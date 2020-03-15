#!/bin/bash

source ~/.config/polybar/scripts/env.sh

#	Increase the volume by x%
increaseAmount=1

#	With drawBox = true
#	┌────────────────────┐
#	│████████████▃░░░░░░░│ 62%
#	└────────────────────┘

#	With drawBox = false
#	████████████▃░░░░░░░ 62%
drawBox=true

#	Default icon
icon=/usr/share/icons/Paper/scalable/status/display-brightness-medium-symbolic.svg

#	Default urgency level [Available: low, normal, critical]
urgency=normal

#	For how much milliseconds the notification will stay visible
timeout=1500

#	Unique dunst notification id
uid=2594

line=$(seq -s "─" 0 5 100 | sed 's/[0-9]//g')

function getBrightness {
    xbacklight -get
}

function sendNotification {
    brightness=`getBrightness`	
    
    #	Building the brightness bar
	if [ $(( ($brightness-4) % 5 )) -eq 0 ]; then
		midBar=▆
	elif [ $(( ($brightness-3) % 5 )) -eq 0 ]; then
		midBar=▅
	elif [ $(( ($brightness-2) % 5 )) -eq 0 ]; then
		midBar=▃
	elif [ $(( ($brightness-1) % 5 )) -eq 0 ]; then
		midBar=▁
	fi
    bar=$(seq -s "█" 0 5 $brightness | sed 's/[0-9]//g'  )
    emptyBar=$(seq -s "░" $(( ((100-$brightness) /5)+1 )) | sed 's/[0-9]//g')	
    
   	if [ $drawBox = true ]; then    
		if [ "$REDSHIFT" = "on" ]; then
			body="┌$line┐\t<b>$brightness%</b>\n│$bar$midBar$emptyBar│\n└$line┘\t<b>$REDSHIFT_TEMP\k</b>"    	
		else
	 	    body="┌$line┐\n│$bar$midBar$emptyBar│\t<b>$brightness%</b>\n└$line┘"
		fi
    else
    	if [ "$REDSHIFT" = "on" ]; then
			body="$bar$midBar$emptyBar <b>$brightness% $REDSHIFT_TEMP\k</b>"    	
		else
	 	    body="$bar$midBar$emptyBar <b>$brightness%</b>"
		fi
    fi
    if [ $brightness -gt 50 ]; then
		icon=/usr/share/icons/Paper/scalable/status/display-brightness-high-symbolic.svg
	fi
    # Send the notification
    dunstify -a "Brightness" -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$brightness%" "$body"
    
}

case $1 in
    up)
     xbacklight -inc 1
	  sendNotification
	;;
    down)
     xbacklight -dec 1
	  sendNotification
	;;
esac
