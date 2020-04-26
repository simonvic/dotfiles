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


#	Default icon
mutedIcon=/usr/share/icons/Vimix-Ruby/22/panel/microphone-sensitivity-muted.svg
lowIcon=/usr/share/icons/Vimix-Ruby/22/panel/microphone-sensitivity-low.svg
icon=/usr/share/icons/Vimix-Ruby/22/panel/microphone-sensitivity-medium.svg
warningIcon=/usr/share/icons/Vimix-Ruby/22/panel/microphone-sensitivity-high.svg

# Enable to play sound
playSound=true
# Sound to play (usually located in /usr/share/sounds/)
sound=/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga

#	Default urgency level [Available: low, normal, critical]
urgency=normal

#	At which level you are controlling the boost and not intput volume anymore
warningLevel=60

#	For how much milliseconds the notification will stay visible
timeout=1500

#	Unique dunst notification id
uid=2592

# App name in dunst
appName="simonvic.Microphone"

function getVolume {
  amixer sget Capture csvolume | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function isMute {
  amixer get Capture | grep '%' | grep -oE '[^ ]+$' | grep off
}

function buildBar {
	$HOME/.config/i3/scripts/drawBar.sh $1 $2 $3
}

function sendNotification {
  volume=`getVolume`

	# Building the volume bar
	body="`buildBar 5 $volume false`\t<b>$volume%</b>\t"

	if [ $volume -ge $warningLevel ]; then
  	urgency=critical
		icon=$warningIcon
	elif [ $volume -le 20 ]; then
		icon=$lowIcon
	fi
	
	if [ $playSound = true ]; then
		paplay $sound &
	fi
	
  # Send the notification
  dunstify -a "$appName" -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$volume" "$body" 

}

case $1 in
	up)
		amixer sset Capture cap
		amixer -D pulse sset Capture csvolume "$2"%+ > /dev/null
		sendNotification
	;;
	down)
		amixer sset Capture cap
		amixer -D pulse sset Capture csvolume "$2"%- > /dev/null
		sendNotification
	;;
	mute)
		amixer -D pulse sset Capture toggle > /dev/null
		if isMute ; then
			# Building the volume bar
			body="`buildBar 5 100 true`\t<b>Muted</b>\t"
			
			dunstify -a "$appName" -i $mutedIcon -t "$timeout" -r "$uid" -u "$urgency" "Muted" "$body"
		else
			  sendNotification
		fi		
 	;;
esac
