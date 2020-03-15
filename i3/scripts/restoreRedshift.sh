#!/bin/bash

source ~/.config/polybar/scripts/env.sh

if [ "$REDSHIFT" = "on" ]; then
	redshift -O "$REDSHIFT_TEMP"
fi
