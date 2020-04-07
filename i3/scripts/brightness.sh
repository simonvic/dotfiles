#!/bin/bash

source ~/.config/polybar/scripts/env.sh


#	With drawBox = true
#	┌────────────────────┐
#	│████████████▃░░░░░░░│ 62%
#	└────────────────────┘

#	With drawBox = false
#	████████████▃░░░░░░░ 62%
drawBox=false

#	Default icon
lowIcon=/usr/share/icons/Vimix-Ruby/symbolic/status/display-brightness-low-symbolic.svg
icon=/usr/share/icons/Vimix-Ruby/symbolic/status/display-brightness-medium-symbolic.svg
highIcon=/usr/share/icons/Vimix-Ruby/symbolic/status/display-brightness-high-symbolic.svg

# Enable to play sound
playSound=true
# Sound to play (usually located in /usr/share/sounds/)
sound=/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga

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
  
  if [ $brightness -ge 60 ]; then
		icon=$highIcon
	elif [ $brightness -le 30 ]; then
		icon=$lowIcon
	fi
	
    # Send the notification
    dunstify -a "Brightness" -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$brightness%" "$body"
    
    if [ $playSound = true ]; then
 			paplay $sound
		fi
}

case $1 in
    up)
     xbacklight -inc $2
	  sendNotification
	;;
    down)
     xbacklight -dec $2
	  sendNotification
	;;
esac
