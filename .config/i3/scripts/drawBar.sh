steps=$1
length=$2
drawEmpty=$3

# TO-DO make colored warning bar
if [ $drawEmpty = false ]; then
	bar=$(seq -s "█" 0 $steps $length | sed 's/[0-9]//g') 
	if [ $(( ($length-4) % $steps )) -eq 0 ]; then
		midBar=▆
	elif [ $(( ($length-3) % $steps )) -eq 0 ]; then
		midBar=▅
	elif [ $(( ($length-2) % $steps )) -eq 0 ]; then
		midBar=▃
	elif [ $(( ($length-1) % $steps )) -eq 0 ]; then
		midBar=▁
	fi
  emptyBar=$(seq -s "░" $(( ((100-$length) / $steps ) +1 )) | sed 's/[0-9]//g')
	finalBar="$bar$midBar$emptyBar"
elif [ $drawEmpty = true ]; then
	finalBar="$(seq -s "░" $(($length/$steps +1)) | sed 's/[0-9]//g')"
fi

echo $finalBar
