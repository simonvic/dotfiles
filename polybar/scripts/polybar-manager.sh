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

TRAY=/tmp/polybar_tray_id

BARS[0]=/tmp/polybar_window_id_main
BARS[1]=/tmp/polybar_window_id_secondary
BARS[2]=/tmp/polybar_window_id_tertiary
# add as many bars as you wish (as long as they're defined correctly in the polybar config file)
# and remember to update the launch function with the correct polybar name
# BARS[3]=/tmp/polybar_window_id_blahblahblah


function launchPolybar() {
	# Terminate already running bar instances
	killall -q polybar
	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
	
	
	# Start new bars
	polybar main &
  echo "$(xdotool search --all --sync --pid $! --classname 'Polybar'):visible" > ${BARS[0]}
	
  polybar secondary &
  echo "$(xdotool search --all --sync --pid $! --classname 'Polybar'):visible" > ${BARS[1]}
  
  polybar tertiary &
  echo "$(xdotool search --all --sync --pid $! --classname 'Polybar'):visible" > ${BARS[2]}
  
  # polybar blah blah blah &
  # ...
  
 	# Search tray id if activated in any of the above bars
	echo "$(xdotool search --classname 'tray'):visible" > $TRAY
}

function launch() {
  launchPolybar
  hide 1
  hide 2 
  #TO-DO add conky :)
}

function showAll() {
	for i in "${!BARS[@]}"
	do
		show $i
	done
}

function hideAll() {
	for i in "${!BARS[@]}"
	do
		hide $i	
	done
}

function show() {
	windowId=$(cat ${BARS[$1]} | cut -d ":" -f1)
	xdotool windowmap $windowId
	echo "$windowId:visible" > ${BARS[$1]}
}

function hide() {
	windowId=$(cat ${BARS[$1]} | cut -d ":" -f1)
	xdotool windowunmap $windowId
	echo "$windowId:invisible" > ${BARS[$1]}
}

function toggle() {
	status=$(cat ${BARS[$1]} | cut -d ":" -f2)
	if [ $status = "visible" ]; then
		hide $1
	elif [ $status = "invisible" ]; then
		show $1
	fi
}

# used in the polybar module
function status() {
	status=$(cat ${BARS[$1]} | cut -d ":" -f2)
	if [ $status = "visible" ]; then
		echo " 蘒 "
	elif [ $status = "invisible" ]; then
		echo " 﨡 "
	fi
}

# TO-DO 
#	The toggle status doesn't update when the parent bar changes status
# maybe use getwindowpid and find the parent
function toggleTray() {
	status=$(cat $TRAY | cut -d ":" -f2)
	if [ $status = "visible" ]; then
		windowId=$(cat $TRAY | cut -d ":" -f1)
		xdotool windowunmap $windowId
		echo "$windowId:invisible" > $TRAY
	elif [ $status = "invisible" ]; then
		windowId=$(cat $TRAY | cut -d ":" -f1)
		xdotool windowmap $windowId
		echo "$windowId:visible" > $TRAY
	fi
}

#to-do add delay and stuff
function autoHide() {
	xdotool behave_screen_edge --delay 500 top exec $HOME/.config/polybar/scripts/polybar-manager.sh show $1 &
	xdotool behave $(cat ${BARS[$1]} | cut -d ":" -f1)	mouse-leave exec $HOME/.config/polybar/scripts/polybar-manager-autohide.sh $1
}

function printUsage() {
	printf "
-Usage
	polybar-manager.sh <options>
	
-Available bar id: "
	for i in "${!BARS[@]}"
	do
		printf "$i "	
	done
printf "

-Options
	help			Show this help
	launch			Launch all polybars defined
	toggle <bar id>		Show and hide the specified bar.
				Available bars id:
				To add a new bar create it in polybar config file and edit polybar-manager accordingly (to-do easier implementation)
	showAll			Make all polybars visible
	hideAll			Make all polybars invisible
	status <bar id>		Print status of the specified bar (useful to create a switch in a polybar itself)
	toggleTray		Show and hide the tray (if present in any bar)
[WIP]	autoHide <bar id>	Enable auto-hide for the specified bar. Move the cursor to [position] to show the bar
	show <bar id>		Make the specified bar visible
	hide <bar id>		Make the specified bar invisible
"
}

if [ -z "$1" ] || [ $1 = "help" ]; then
	printUsage
else
	case "$1" in
		launch)
			launch;;
		toggle)
			toggle $2;;
		showAll)
			showAll;;
		hideAll)
			hideAll;;
		status)
			status $2;;
		toggleTray)
			toggleTray;;
		autoHide)
			autoHide $2;;
		show)
			show $2;;
		hide)
			hide $2;;
	esac
fi
