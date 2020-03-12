#!/bin/bash

function get_brightness {
    xbacklight -get
}

function send_notification {
    brightness=`get_brightness`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
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
    emptyBar=$(seq -s "░" $(( ((100-$brightness) /5)+1 )) | sed 's/[0-9]//g'  )
    # Send the notification
    dunstify -a "Brightness" -i xxx -t 1000 -r 2593 -u normal "$brightness%" "$bar$midBar$emptyBar"
}

case $1 in
    up)
     xbacklight -inc 10 # -step 10
	  send_notification
	;;
    down)
     xbacklight -dec 10 # -step 10
	  send_notification
	;;
esac
