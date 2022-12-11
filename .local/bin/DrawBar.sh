#!/bin/bash

###########################################
#	Made by
#       _                              _
#      (_)                            (_)
#  ___  _  ____    ___   ____   _   _  _   ____
# /___)| ||    \  / _ \ |  _ \ | | | || | / ___)
#|___ || || | | || |_| || | | | \ V / | |( (___
#(___/ |_||_|_|_| \___/ |_| |_|  \_/  |_| \____)
#
#	Check updates and give a look at my dotfiles here:
#		https://github.com/simonvic/dotfiles
#
###########################################


BORDER_CHARS=( 
┌ ─ ┐
│   │
└ ─ ┘
)

BAR_CHARS=( █ ░ )


function draw() {
	local normalizedValue=$((value / step))
	if [ $length -lt $normalizedValue ]; then
		length=$normalizedValue
	fi
	local currentStep=$(( step - (value % step) ))
	local emptyCount=$(( length - normalizedValue ))
	

	printf "%s" "$prefix"

	##################### Draw top border #####################
	if $drawBorders; then
		printf "%s" "${BORDER_CHARS[0]}"
		for i in $(seq $length); do
			printf "%s" "${BORDER_CHARS[1]}"
		done
		printf "%s" "${BORDER_CHARS[2]}"
		if [ ! -z "${BORDER_CHARS[2]}" ]; then  # Avoid printing new line if top border is empty
			printf "\n"
		fi
		printf "%s" "${BORDER_CHARS[3]}"
	fi

	##################### Draw filled steps #####################
	for ((i=0; i<normalizedValue; i++)); do
		printf "%s" "${BAR_CHARS[0]}"
	done

	##################### Draw current step #####################
	if [ $normalizedValue -ne $length ]; then
		printf "%s" "${BAR_CHARS[ $(( currentStep )) ]}"
	fi

	##################### Draw empty BAR_CHARS #####################
	for ((i=0; i<emptyCount-1; i++)); do
		printf "%s" "${BAR_CHARS[ $step ]}"
	done

	printf "%s" "$suffix"

	##################### Draw bottom border #####################
	if $drawBorders; then
		printf "%s\n" "${BORDER_CHARS[4]}"
		printf "%s" "${BORDER_CHARS[5]}"
		for i in $(seq $length); do
			printf "%s" "${BORDER_CHARS[6]}"
		done
		printf "%s" "${BORDER_CHARS[7]}"
	fi

}

function printUsage() {
	printf "%s\n" "
- Usage
	DrawBar.sh [options]
	
- Options
	-h, --help                  Show this help.
	-l, --length                Specify the length (in columns) of the bar.
	-v, --value                 Specify the value of the bar.
	-s, --step                  Specify the step for the bar value.
	                              A length of 20 with step of 5 will produce
	                              a bar 20 columns long, where each 5 unit of the
	                              specified value will be represented by one column.
	                              A character must be defined for each step. See
	                              the --bar-chars option.

	-c, --bar-chars             Specify a semicolon separated list of characters.
	                              to use as bar.
	                              A character must be specified for each step, plus
	                              another character for the \"empty part\" of the bar.

	                              Example: '#;-'
	                              with length=10, step=1 and value 6
	                              Will produce a bar like the following:
	                              ######----

	                              Example 2: '█;▆;▅;▃;▁;░'
	                              with length=10, step=5 and value=23
	                              Will produce a bar like the following:
	                              ████▅░░░░░
	                              NOTE: multiple characters for each step
	                              (spaces included) can be used.

	                              Some cool alternatives:
	                                '█;▆;▅;▃;▁;░'
	                                '█;▉;▋;▍;▏; '
	                                '█;▓;▒;░; ; '
	                                '⣿;⠗;⠕;⠆;⠂; '
	
	-b, --borders <chars>       Specify a semicolon separated list of characters
	                              to use as borders.

	                              Example: '┌;─;┐;│;│;└;─;┘'
	                              Will produce borders like the following:
	                              ┌───────────────────┐
	                              │                   │
	                              └───────────────────┘
	                              NOTE: none or multiple characters (spaces
	                              included) can be used.

	                              Some cool alternatives:
	                                '┌;─;┐;│;│;└;─;┘'
	                                '+;-;+;|;|;+;-;+'
	                                ';;;|;|;;;'
	                                '┌; ;┐; ; ;└; ;┘'
	                                '┌;─;┐;│;Some text after;└;─;┘'

"
}

function setupLaunchParameters() {
	shortOpt="hb:l:v:s:c:"
	longOpt="help,borders:,length:,value:,step:,bar-chars:"

	PARSED_ARGUMENTS=$(getopt -n BarDrawer.sh -o ${shortOpt} --long ${longOpt} -- "$@")
	if [ "$?" != "0" ]; then
		printUsage
		exit 1
	fi

	eval set -- "$PARSED_ARGUMENTS"

	while true; do
		case $1 in
		-h | --help)
			printUsage
			exit 1
			;;
		-b | --borders)
			drawBorders=true
			IFS=';' read -ra BORDER_CHARS <<< "$2"
			shift
			;;
		-l | --length)
			length=$2
			shift
			;;
		-v | --value)
			value=$2
			shift
			;;
		-s | --step)
			step=$2
			shift
			;;
		-c | --bar-chars)
			IFS=';' read -ra BAR_CHARS <<< "$2"
			shift
			;;
		--)
			shift
			break
			;;
		*)
			echo "Invalid option: $1"
			printUsage
			exit 1
			;;
		esac
		shift #go to next arg
	done
}

#############################################
# MAIN
setupLaunchParameters "$@"

length=${length:-10}
step=${step:-1}
value=${value:-5}
drawBorders=${drawBorders:-false}

draw
