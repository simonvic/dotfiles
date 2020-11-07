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

function launch() {
	killPolybars

	launchPolybar "main"
	launchPolybar "secondary"
	launchPolybar "tertiary"
	
	sleep 1
	hide "secondary"
}

function killPolybars() {
	killall -q polybar
}

function launchPolybar() {
	if [ ! -z "$1" ]; then
		polybar $1 >>/tmp/polybar_$1.log 2>&1 & disown
		rm /tmp/polybar_ipc_$1
		ln -sf /tmp/polybar_mqueue.$! /tmp/polybar_ipc_$1
	fi
}

function showAll() {
	polybar-msg cmd show
}

function hideAll() {
	polybar-msg cmd hide
}

function show() {
	[ ! -z "$1" ] && echo cmd:show >/tmp/polybar_ipc_$1
}

function hide() {
	[ ! -z "$1" ] && echo cmd:hide >/tmp/polybar_ipc_$1
}

function toggle() {
	[ ! -z "$1" ] && echo cmd:toggle >/tmp/polybar_ipc_$1
}

function status() {
	echo "-o"
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

function printUsage() {
	printf "
-Usage
	polybar-manager.sh <options>
	
-Available bar :
"
	ls /tmp/ | grep polybar_ipc_
	printf "

-Options
	help			Show this help
	launch			Launch all polybars defined
	toggle <bar name>		Show and hide the specified bar.
	showAll			Make all polybars visible
	hideAll			Make all polybars invisible
[DEPRECATED]	status <bar name>		Print status of the specified bar (useful to create a switch in a polybar itself)
[DEPRECATED]	toggleTray		Show and hide the tray (if present in any bar)
[WIP]	autoHide <bar id>	Enable auto-hide for the specified bar. Move the cursor to [position] to show the bar
[WIP]	drag <bar id>	Drag the polybar with the mouse
[WIP]	resize <bar id>	Resize the polybar with the mouse
	show <bar name>		Make the specified bar visible
	hide <bar name>		Make the specified bar invisible
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
		;;
	showAll)
		showAll
		;;
	hideAll)
		hideAll
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
		;;
	hide)
		hide $2
		;;
	drag)
		drag $2
		;;
	resize)
		resize $2
		;;
	esac
fi
