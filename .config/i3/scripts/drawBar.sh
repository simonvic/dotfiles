steps=$1
length=$2
drawEmpty=$3

fullChar="█"
midChar0="▆"
midChar1="▅"
midChar2="▃"
midChar3="▁"
midPoint=""
emptyChar="░"


# Line
#fullChar="━"
#midChar0="╾"
#midChar1="╾"
#midChar2="╾"
#midChar3="╾"
#midPoint=""
#emptyChar="─"

# Using braille
#fullChar="⣿"
#midChar0="⡷"
#midChar1="⡇"
#midChar2="⠆"
#midChar3="⠂"
#midPoint=""
#emptyChar="⠀"

# TO-DO make colored warning bar
if [ $drawEmpty = false ]; then
	bar=$(seq -s $fullChar 0 $steps $length | sed 's/[0-9]//g') 
	if [ $(( ($length-4) % $steps )) -eq 0 ]; then
		midBar=$midChar0
	elif [ $(( ($length-3) % $steps )) -eq 0 ]; then
		midBar=$midChar1
	elif [ $(( ($length-2) % $steps )) -eq 0 ]; then
		midBar=$midChar2
	elif [ $(( ($length-1) % $steps )) -eq 0 ]; then
		midBar=$midChar3
	fi
  emptyBar=$(seq -s $emptyChar $(( ((100-$length) / $steps ) +1 )) | sed 's/[0-9]//g')
	finalBar="$bar$midBar$midPoint$emptyBar"
elif [ $drawEmpty = true ]; then
	finalBar="$(seq -s $emptyChar $(($length/$steps +1)) | sed 's/[0-9]//g')"
fi

echo $finalBar
