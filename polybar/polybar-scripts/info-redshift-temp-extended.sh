#!/bin/sh


    color=$(redshift -p 2> /dev/null | grep Color | cut -d ":" -f 2 | tr -dc "[:digit:]")
    temp=($(redshift -p 2> /dev/null | grep Brightness | cut -d ":" -f 2 | tr -dc "[:digit:]") * 100);

    if [ -z "$color" ]; then
        echo "%{F#65737E}  $color k"
    elif [ "$color" -ge 5000 ]; then
        echo "%{F#8FA1B3}  $color k"
    elif [ "$color" -ge 4000 ]; then
        echo "%{F#EBCB8B}  $color k"
    else
        echo "%{F#D08770}  $color k"
    fi

