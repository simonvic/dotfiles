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

# Bing base address
bing="http://www.bing.com"

# Base url
url=$bing"/HPImageArchive.aspx?"

# Response Format (json or xml or rss)
url+="&format=rss"

# Day id (0=today, 1=yesterday ...)
url+="&idx=0"

# Region (it-IT for Italy, en-US for USA etc. )
url+="&mkt=it-IT"

# How many photo to download.
url+="&n=1"

# Url of the image to be downloaded
imageURL=$bing$(wget --quiet -O - $url | awk -F'src="' '{print $2}' | cut -d '&' -f1)

wget --quiet -O - $imageURL | feh --bg-fill -




