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


visibleIcon=" 蘒 "
invisibleIcon=" 﨡 "
defaultPolybarName="*"
defaultHookId=1

function launch() {
	killPolybars

	launchPolybar "main"
	launchPolybar "secondary"
	launchPolybar "tertiary"
	
	sleep 1
	hide "secondary"
	hide "tertiary"
}

function killPolybars() {
	killall -q polybar
	rm /tmp/polybar_ipc_*
}

function launchPolybar() {
	if [ ! -z "$1" ]; then
		polybar $1 &
		ln -s /tmp/polybar_mqueue.$! /tmp/polybar_ipc_$1
	fi
}

function show() {
	ipc cmd show $1
}

function hide() {
	ipc cmd hide $1
}

function toggle() {
	ipc cmd toggle $1
}

function updateSwitches(){
	ipc hook bar-switch-secondary
	ipc hook bar-switch-tertiary
}

function status() {
	case "$( xwininfo -name "polybar_$1" | grep "Map State:" | cut -d " " -f5 )" in
		IsViewable) echo "$visibleIcon" ;;
		IsUnMapped) echo "$invisibleIcon" ;;
		*) echo "unknwonState";;
	esac		
}

function toggleTray() {
	#to-do reimplement with pid
	echo "Needs to be reimplemented"
}

function autoHide() {
	#to-do reimplement with pid
	#to-do add delay and stuff
	echo "Needs to be reimplemented"
}

function drag() {
	#to-do reimplement with pid
	echo "Needs to be reimplemented"
}

function resize() {
	#to-do reimplement with pid
	echo "Needs to be reimplemented"
}

function ipc(){
	command=$1
	payload=$2
	if [ -z $1 ] && [ -z $2 ]; then
		echo "Error, message malformed"
		return 1;
	fi
	
	case $command in
	hook)
		regex='^[0-9]+$'
		if [ ! -z $3 ] && [[ $3 =~ $regex ]]; then
			hookId=$3
		else
			hookId=$defaultHookId
		fi
		payload=module/$payload$hookId
		polybarName=$4	
	;;
	cmd | action)
		polybarName=$3
	;;
	esac;
	
	if [ -z $polybarName ]; then
		polybarName=$defaultPolybarName
	fi

	echo $command:$payload | tee -a /tmp/polybar_ipc_$polybarName
}

function printUsage() {
	printf "
- Usage
	polybar-manager.sh <options>
	
- Available bar name:
"
	ls /tmp/ | grep polybar_ipc_ | cut -d "_" -f3
	printf "

-Options
	help			Show this help
	launch			Launch all polybars defined
	show [bar name]		Make the specified bar visible, or leave empty to show all bars
	hide [bar name]		Make the specified bar invisible, or leave empty to hide all bars
	toggle [bar name]		Show and hide the specified bar, or leave empty to toggle all
	status <bar name>		Print status of the specified bar (useful to create a switch in a polybar itself)
	ipc <command=(action|cmd|hook)> <payload> [hook-id] [polybar-name]	Send an inter-process mesage
	 - if using command=hook, use [hook-id] to specify the index (1-based) of the hook configured in the polybar config. Default: 1
	 - use [polybar-name] to send the IPC message to the specified polybar. Default: all polybars
	 Examples:
	  $ ./polybar-manager.sh ipc action menu-open-1 myBar	# simulate the menu open on the 'myBar' bar 
	  $ ./polybar-manager.sh ipc cmd show myOtherBar 	# show the 'myOtherBar' bar
	  $ ./polybar-manager.sh ipc cmd hide 	# hide all bars
	  $ ./polybar-manager.sh ipc hook myModule 	# call the first defined hook of 'myModule' in all bars
	  $ ./polybar-manager.sh ipc hook myModule 2 	# call the second defined hook of 'myModule' in all bars
	  $ ./polybar-manager.sh ipc hook myModule 2 myBar 	# call the first defined hook of 'myModule' in all bars 'myBar'
[DEPRECATED]	toggleTray		Show and hide the tray (if present in any bar)
[WIP]	autoHide <bar id>	Enable auto-hide for the specified bar. Move the cursor to [position] to show the bar
[WIP]	drag <bar id>	Drag the polybar with the mouse
[WIP]	resize <bar id>	Resize the polybar with the mouse
"
}

if [ -z "$1" ] || [ $1 = "help" ]; then
	printUsage
else
	case "$1" in
	launch)
		launch
		;;
	toggle)
		toggle $2
		updateSwitches
		;;
	status)
		status $2
		;;
	toggleTray)
		toggleTray
		;;
	autoHide)
		autoHide $2
		;;
	show)
		show $2
		updateSwitches
		;;
	hide)
		hide $2
		updateSwitches
		;;
	drag)
		drag $2
		;;
	resize)
		resize $2
		;;
	ipc)
		ipc $2 $3 $4 $5
	;;
	esac
fi
