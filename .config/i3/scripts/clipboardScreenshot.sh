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

tempScreenshotFile=/tmp/simonvic/i3/clipboardScreenshot.png

# Create folder if not present
if [ ! -e $tempScreenshotFile ]; then
    mkdir -p $(echo $tempScreenshotFile | rev | cut -d"/" -f2- | rev)
fi

if [ $1 == "selection" ]; then
    scrot -o $tempScreenshotFile -s -e 'xclip -selection clipboard -target image/png -i $f'
else
    scrot -o $tempScreenshotFile -e 'xclip -selection clipboard -target image/png -i $f'
fi
