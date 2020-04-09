#!/bin/sh

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

envFile=~/.config/polybar/scripts/env.sh
changeValue=300

changeMode() {
  sed -i "s/REDSHIFT=$1/REDSHIFT=$2/g" $envFile 
  REDSHIFT=$2
  echo $REDSHIFT
}

changeTemp() {
  if [ "$2" -gt 1000 ] && [ "$2" -lt 25000 ]
  then
    sed -i "s/REDSHIFT_TEMP=$1/REDSHIFT_TEMP=$2/g" $envFile 
    redshift -P -O $((REDSHIFT_TEMP+changeValue))
  fi
}

case $1 in 
  toggle) 
    if [ "$REDSHIFT" = on ];
    then
      changeMode "$REDSHIFT" off
      redshift -x
    else
      changeMode "$REDSHIFT" on
      redshift -O "$REDSHIFT_TEMP"
    fi
    ;;
  increase)
    changeTemp $((REDSHIFT_TEMP)) $((REDSHIFT_TEMP+changeValue))
    ;;
  decrease)
    changeTemp $((REDSHIFT_TEMP)) $((REDSHIFT_TEMP-changeValue));
    ;;
  temperature)
    case $REDSHIFT in
      on)
        printf "  %dK" "$REDSHIFT_TEMP"
        ;;
      off)
        printf "  "
        ;;
    esac
    ;;
esac
