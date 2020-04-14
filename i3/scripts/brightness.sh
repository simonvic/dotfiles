#!/bin/bash

###########################################
#	Made by
#       _                              _        
#      (_)                            (_)       
#  ___  _  ____    ___   ____   _   _  _   ____ 
# /___)| ||    \  / _ \ |  _ \ | | | || | / ___)
#|___ || || | | || |_| || | | | \ V / | |( (___ 
#(___/ |_||_|_|_| \___/ |_| |_|  \_/  |_| \____)

#	Check updates and give a look at my dotfiles here:
#		https://github.com/simonvic/dotfiles

###########################################


# Draw box in notification
#	With drawBox = true
#	┌────────────────────┐
#	│████████████▃░░░░░░░│ 62%
#	└────────────────────┘

#	With drawBox = false
#	████████████▃░░░░░░░ 62%
drawBox=false

#	Default icons
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

# Default values
defaultBrightnessChangeValue=1
defaultTempChangeValue=100
screensaverBrightnessValue=1
# Transitions smoothnesss and time
fade_steps=1
fade_time=100
fade_fps=240

screensaver_steps=50
screensaver_time=1000
screensaver_fps=240

# Store redshift status and temperature
redshiftState=~/.config/i3/scripts/redshift.sh
source $redshiftState

#	Unique dunst notification id
uid=2594

#####################################################################







function getBrightness {
	xbacklight -get
}

function setBrightness {
	xbacklight -set $1
}

function toggleRedshift() {
	if [ "$REDSHIFT_STATUS" = on ]; then
		sed -i "s/REDSHIFT_STATUS=on/REDSHIFT_STATUS=off/g" $redshiftState
		redshift -x
		REDSHIFT_STATUS=off
	elif [ "$REDSHIFT_STATUS" = off ]; then
		sed -i "s/REDSHIFT_STATUS=off/REDSHIFT_STATUS=on/g" $redshiftState
		redshift -O "$REDSHIFT_TEMP"
		REDSHIFT_STATUS=on
	fi
}

function changeTemp() {
  if [ "$1" -gt 1000 ] && [ "$1" -lt 25000 ]; then
    sed -i "s/REDSHIFT_TEMP=$REDSHIFT_TEMP/REDSHIFT_TEMP=$1/g" $redshiftState
    redshift -P -O $1
    REDSHIFT_TEMP=$1
  fi
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
 		line=$(seq -s "─" 0 5 100 | sed 's/[0-9]//g') 
		if [ "$REDSHIFT_STATUS" = "on" ]; then
			body="┌$line┐\t<b>$brightness%</b>\n│$bar$midBar$emptyBar│\n└$line┘\t<b>$REDSHIFT_TEMP\k</b>"    	
		else
		  body="┌$line┐\n│$bar$midBar$emptyBar│\t<b>$brightness%</b>\n└$line┘"
		fi
  else
  	if [ "$REDSHIFT_STATUS" = "on" ]; then
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
 			paplay $sound &
		fi
}

function printBrightness() {
	brightness=`getBrightness`
	if [ $brightness -le 20 ]; then
		suffix=
	elif [ $brightness -le 40 ]; then
		suffix=
	elif [ $brightness -le 60 ]; then
		suffix=
	elif [ $brightness -le 100 ]; then
		suffix=
	fi
	
	if [ "$1" = "extended" ]; then
		bar="$(seq -s '─' 0 $((brightness/10 -1 )) | sed 's/[0-9]//g')│"
		emptyBar="$(seq -s '─' 0 $((10 - brightness/10)) | sed 's/[0-9]//g')"
		body=$brightness%$bar$emptyBar
	fi
	echo "%{F$color}$suffix  $body%{B- F-}"
	
}

function printTemperature() {
# Cool but, is it necessary?
#	if [ $REDSHIFT_TEMP -le 2000 ]; then
#		color="#eb6234"
#	elif [ $REDSHIFT_TEMP -le 3000 ]; then
#		color="#eb9334"
#	elif [ $REDSHIFT_TEMP -le 5000 ]; then
#		color="#e2eb34"
#	elif [ $REDSHIFT_TEMP -le 10000 ]; then
#		color="#34ebdb"
#	elif [ $REDSHIFT_TEMP -le 25000 ]; then
#		color="#0000FF"
#	fi
	body=""
	if [ $REDSHIFT_STATUS = off ]; then
		suffix=盛
	else
		suffix=
		body=""
		if [ "$1" = "extended" ]; then
			body="$REDSHIFT_TEMP K"
		fi
	fi
	echo "%{F$color}$suffix $body%{B- F-}"
}

function screensaver() {
	trap 'exit 0' TERM INT
	trap "setBrightness $(getBrightness); kill %%" EXIT
	setBrightness "$screensaverBrightnessValue -fps $screensaver_fps -time $screensaver_time"
	sleep 2147483647 &
	wait
}

case $1 in
    increase)
    	if [ -z $2 ]; then
    		xbacklight -inc $defaultBrightnessChangeValue -steps $fade_steps -time $fade_time
    	else
				xbacklight -inc $2 -steps $fade_steps -time $fade_time
			fi
			sendNotification
			;;
    decrease)
    	if [ -z $2 ]; then
    		xbacklight -dec $defaultBrightnessChangeValue -steps $fade_steps -time $fade_time
    	else
				xbacklight -dec $2 -steps $fade_steps -time $fade_time
			fi
			sendNotification
			;;
		set)
			setBrightness "$2 -step $fade_fps -time $fade_time"
			sendNotification
			;;
		screensaver)
			screensaver
			;;
		print)
			printBrightness $2
			;;
		redshift)
			case $2 in
				toggle)
					toggleRedshift
					sendNotification
				;;
				increase)
					if [ -z $3 ]; then
						changeTemp $((REDSHIFT_TEMP+defaultTempChangeValue))
					else
						changeTemp $((REDSHIFT_TEMP+$3))
					fi
					sendNotification
					;;
				decrease)
					if [ -z $3 ]; then
						changeTemp $((REDSHIFT_TEMP-defaultTempChangeValue))
					else
						changeTemp $((REDSHIFT_TEMP-$3))
					fi
					sendNotification
					;;
				print)
					printTemperature $3
					;;
			esac
		;;
esac
