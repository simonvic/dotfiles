#!/bin/sh

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



### Call this script in a crontab (preferably every minute)
### EXAMPLE of my crontab:
### 	* * * * * DISPLAY=':0' DBUS_SESSION_BUS_ADDRESS='unix:path=/run/user/1000/bus' $HOME/Documents/Programming/scripts/battery-manager/battery.sh monitor


# Show more info in notification
moreInfo=true

#	Default icon
icon=battery-medium

#	Default urgency level [Available: low, normal, critical]
urgency=normal

# Enable to play sound
playSound=true
# Sound to play (usually located in /usr/share/sounds/)
sound=/usr/share/sounds/freedesktop/stereo/message.oga

#	For how much milliseconds the notification will stay visible
timeout=3000

#	Unique dunst notification id
uid=2596

# App name in dunst
appName="simonvic.Battery"

isFullyCharged=/tmp/battery-status


function getStatus {
	acpi -b | awk -F '[,:%]' '{print $2}' | cut -d ' ' -f2,3
}

function getCapacity {
	acpi -b | awk -F '[,:%]' '{print $3}' | cut -d ' ' -f2
}

function getTemp {
	case $tempUnit in
		celsius)
			tempUnit=""
			unit="°C"
		;;
		fahrenheit)
			tempUnit="-f"
			unit="°F"
		;;
		kelvin)
			tempUnit="-k"
			unit="K"
		;;
		*)
			tempUnit=""
			unit="°C"
		;;
	esac
	echo "$(acpi -t | awk -F " " '{print $4}') $unit"
}

function getTime {
	acpi -b | awk -F ", " '{print $3}'
}

function isFullyCharged {
	cat $isFullyCharged
}

function sendNotification {
	/usr/bin/dunstify -a $appName -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$title" "$body"	
 	if [ $playSound = true ]; then
 		paplay $sound -s /run/user/1000/pulse/native &
 	fi
}

function monitor {
	status=`getStatus`
	capacity=`getCapacity`
	temp=`getTemp`
	time=`getTime`
	
	title="$capacity %"
	
	if [ `isFullyCharged` != "true" -a "$status" = "Not charging" -a "$capacity" -eq 100 ]; then
		body="Battery fully charged"
		urgency=low
		icon=battery-full-charging
		sendNotification
		echo true > $isFullyCharged
	elif [ "$status" = "Discharging" ]; then
		if [ "$capacity" -le 10 ]; then
				body="Battery is at a critical level"
				urgency=critical
				icon=battery-caution
				sendNotification
			elif [ "$capacity" -eq 20 ]; then
				body="Battery will need to be charged soon"
				urgency=normal
				icon=battery-low
				sendNotification
			elif [ "$capacity" -eq 50 ]; then
				body="Battery is <b>$capacity%</b>"
				urgency=low
				icon=battery-060
				sendNotification
			fi
		echo false > $isFullyCharged
	elif [ "$status" = "Charging" ]; then
		if [ "$capacity" -eq 80 ]; then
				title="$capacity %"
				body="IT'S OVER HEIGHTTHOUSAND"
				urgency=low
				timeout=1500
				icon=battery-100-charging
				sendNotification
		fi
		echo false > $isFullyCharged
	fi
}


function plugin {
	capacity=`getCapacity`
	title="$capacity %"
	body="AC plugged"
	urgency=low
	timeout=1500
	icon=battery-000-charging
	sendNotification
}

function unplug {
	capacity=`getCapacity`
	title="$capacity %"
	body="AC unplugged"
	urgency=normal
	timeout=1500
	icon=battery-000
	sendNotification
}

function current {
	status=`getStatus`
	capacity=`getCapacity`
	temp=`getTemp`
	time=`getTime`
	
	if [ "$status" = "Discharging" ]; then
		icon=battery-000
	elif [ "$status" = "Charging" ]; then
		icon=battery-000-charging
	fi
	title="$capacity %"
	body="<b>$status</b>
<small>$time
$temp</small>
"
	sendNotification
}

case $1 in
	monitor)
		monitor
	;;
	plugin)
		plugin
	;;
	unplug)
 		unplug
	;;
	current)
		current
	;;
	*)
	echo "monitor
plugin
unplug
current"
esac
