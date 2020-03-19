#!/bin/bash

#	Default player to control
#	TO-DO make shortcut to change player on the fly
player=spotify

# Show more info abou author and song
moreInfo=false

#	Default urgency level [Available: low, normal, critical]
urgency=low

#	For how much milliseconds the notification will stay visible
timeout=5000

#	Unique dunst notification id
uid=2595


function getTitle {
	playerctl -p "$player" metadata title
}

function getArtist {
	playerctl -p "$player" metadata artist
}

function getAlbum {
	playerctl -p "$player" metadata album
}

function getStatus {
	playerctl -p "$player" status
}

function buildBody() {
	if [ $moreInfo = true ]; then
		printf "<big><b>$title</b></big><small> ($artist)\n$album\n<i>$player</i></small>"
	else
		printf "<big><b>$title</b></big><small> ($artist)</small>"
	fi

}

function sendNotification {
	status=`getStatus`
	if [ $status = "Playing" ]; then
		icon=/usr/share/icons/Paper/scalable/actions/media-playback-start-symbolic.svg
	elif [ $status = "Paused" ]; then	
		icon=/usr/share/icons/Paper/scalable/actions/media-playback-pause-symbolic.svg
	fi
	artist=`getArtist`
	title=`getTitle`
	album=`getAlbum`
	body=`buildBody`
		
    # Send the notification
    dunstify -a "playerctl" -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$title" "$body"
    
}

case $1 in
	play-pause)
		playerctl -p "$player" play-pause
		sendNotification
	;;
	stop)
		playerctl -p "$player" stop
		sendNotification
	;;
	next)
		playerctl -p "$player" next
	;;
	previous)
		playerctl -p "$player" previous
	;;
esac
