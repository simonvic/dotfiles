#!/bin/sh


    color=$(redshift -p 2> /dev/null | grep Color | cut -d ":" -f 2 | tr -dc "[:digit:]")
    temp=($(redshift -p 2> /dev/null | grep Brightness | cut -d ":" -f 2 | tr -dc "[:digit:]") * 100);

    if [ -z "$color" ]; then
        echo "%{F#65737E}  $temp%"
    elif [ "$color" -ge 5000 ]; then
        echo "%{F#8FA1B3}  $temp%"
    elif [ "$color" -ge 4000 ]; then
        echo "%{F#EBCB8B}  $temp%"
    else
        echo "%{F#D08770}  $temp%"
    fi

