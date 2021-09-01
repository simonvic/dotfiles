#!/bin/bash
status=$(earbuds status -o json -q)
if [ "$(echo $status | jq '.status' -r)" == "error" ]; then
	echo ""
	exit 1
fi

battery_left=$(echo $status | jq -r '.payload.batt_left')
battery_case=$(echo $status | jq -r '.payload.batt_case')
battery_right=$(echo $status | jq -r '.payload.batt_right')

if [ "$(echo $BUDS_STATUS | jq '.payload.placement_left')" == "3" ]; then
	battery_left="$battery_left"
fi

if [ "$(echo $BUDS_STATUS | jq '.payload.placement_right')" == "3" ]; then
	battery_right="$battery_right"
fi

function buildOutput() {
	if [[ "$1" == "verbose" ]]; then
		[[ $battery_case -lt 100 ]] && outCase="  $battery_case% " || outCase=" _  ?%  "
		echo " ( $battery_left% | $battery_right% )$outCase"
	else
		echo " ~$((($battery_left + $battery_right) / 2))%"
	fi
}

echo $(buildOutput $1)
