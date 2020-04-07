#!/bin/sh

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



function getStatus {
	acpi -b | awk -F '[,:%]' '{print $2}' | cut -d ' ' -f2,3
}

function getCapacity {
	acpi -b | awk -F '[,:%]' '{print $3}' | cut -d ' ' -f2
}

function sendNotification {
	/usr/bin/dunstify -a "Battery" -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$title" "$body"	
 	if [ $playSound = true ]; then
 		paplay $sound -s /run/user/1000/pulse/native
 	fi
}

function monitor {
	status=`getStatus`
	capacity=`getCapacity`
	
	if [ "$status" = "Not charging" -a "$capacity" -eq 100 ]; then
		title="Not charging"
		body="Battery fully charged"
		urgency=low
		icon=battery-100-charging
		sendNotification
	elif [ "$status" = "Discharging" ]; then
		if [ "$capacity" -le 10 ]; then
				title="Critical"
				body="Battery is at a critical level"
				urgency=critical
				icon=battery-caution
				sendNotification
			elif [ "$capacity" -eq 20 ]; then
				title="Low"
				body="Battery will need to be charged soon"
				urgency=normal
				icon=battery-low
				sendNotification
			elif [ "$capacity" -eq 50 ]; then
				title="Half"
				body="Battery is 50%"
				urgency=low
				icon=battery-medium
				sendNotification
			fi
	elif [ "$status" = "Charging" ]; then
		if [ "$capacity" -eq 80 ]; then
				title="Over 80"
				body="BATTERY IS OVER HEIGHTTHOUSAND"
				urgency=low
				timeout=1500
				icon=battery-080-charging
				sendNotification
		fi
	fi
}


function plugin {
	echo "plugin"
}

function plugout {
	echo "plugout"
}

case $1 in
	monitor)
		monitor
	;;
	plugin)
		plugin
	;;
	plugout)
 		plugout
	;;
esac
