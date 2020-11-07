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

poweredOnIcon=""
poweredOffIcon= #""
conectedIcon=""

function printStatus(){	
	case $(getStatus) in
		no) echo $poweredOffIcon ;;
		yes) echo $poweredOnIcon ;;
		*);;
	esac;
}

function power(){
	if [ $1 == "toggle" ]; then
		case $(getStatus) in
			no) bluetoothctl power on ;;
			yes) bluetoothctl power off ;;
		esac;
	else
		bluetoothctl power $1
	fi
}

function getStatus(){
	bluetoothctl show | grep "Powered" | cut -d " " -f2
}

function updatePolybar(){
	polybar-msg hook bluetooth 1
}

case $1 in
    print)
    	printStatus
  	;;
  	power)
  		power $2 && updatePolybar
  	;;
esac


