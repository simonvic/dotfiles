#!/bin/zsh 
 ###########################################
# dev
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

todoFile=~/Documents/Programming/scripts/todo/todo.txt
doneSymbol=
todoSymbol=

# Notification settings

icon=" "

#	Default urgency level [Available: low, normal, critical]
urgency=normal

#	For how much milliseconds the notification will stay visible
timeout=60000

#	Unique dunst notification id
uid=2597

printHeader() {
echo "
··················································
··················································
████████╗ ██████╗       ██████╗  ██████╗ 
╚══██╔══╝██╔═══██╗      ██╔══██╗██╔═══██╗
   ██║   ██║   ██║█████╗██║  ██║██║   ██║
   ██║   ██║   ██║╚════╝██║  ██║██║   ██║
   ██║   ╚██████╔╝      ██████╔╝╚██████╔╝
   ╚═╝    ╚═════╝       ╚═════╝  ╚═════╝ 
··················································
"
}

printUsage() {
	echo "
Usage
	todo [options]

Options
	help	show this help
	list	[filter]	List things to do with a filter
	done		List things done
	new	<name>		Add a new thing to do with name <name>
	do	<id>		Mark it done
	undo	<id>		Mark it undone
	edit	Edit manually the todo list
"
}

function buildBar {
	$HOME/.config/i3/scripts/drawBar.sh $1 $2 $3
}

sendNotification() {
	doneNum=$(cat $todoFile | grep $doneSymbol | wc -l )
	totalNum=$(cat $todoFile | wc -l )
	todoNum=$(($totalNum - $doneNum))
	todoPercent=$(($doneNum * 100 / $totalNum))
	summary="$doneNum done | $todoNum still to do | $todoPercent"
	body="<small>\n$(cat $todoFile | grep $todoSymbol )</small>\n\n \
		`buildBar 5 $todoPercent false` $todoPercent% \n \
		<b>$todoSymbol $todoNum</b> still to do <b>│</b> <b>$doneSymbol $doneNum</b> done\n "
		
		
  case $(dunstify -a "simonvic.TODO" -A "listAll,  List all" -A "todoHelp,  TODO help" -A "edit,  Edit the todo list" -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$summary" "$body") in
		edit)
			xdg-open $todoFile &
		;;
		listAll)
			/usr/bin/rofi-sensible-terminal -e "cat $todoFile" --hold
		;;
		todoHelp)
			/usr/bin/rofi-sensible-terminal -e "$HOME/Documents/Programming/scripts/todo/todo.sh help" --hold
		;;
	esac
}

if [ -z "$1" ]
then
	printHeader;
	thingsUndone=`grep -c -e  $todoFile`;
	    	if [ $thingsUndone -ge 1 ]
	    	then
  		    	cat $todoFile | grep $todoSymbol
  		   else
  		   	echo "Nothing to do! NICE! (this is pure utopia)"
  		   fi
	
else
	case $1 in 
		list)
			printHeader;
			words=`grep -c -e  $todoFile`;
	    	if [ $words -ge 1 ]
	    	then
	    		if [ -z "$2" ]
	    		then
	    			cat $todoFile
	    		else
	    			cat $todoFile | grep $2
	    		fi
	    	fi
	    ;;
	    done)
	    	printHeader;
	    	cat $todoFile | grep $doneSymbol
	    ;;
	    help)
	    	printHeader;
	    	printUsage;
	    ;;
	    new)
	    	if [ -z "$2" ]
	    	then
	    		printUsage;	    	
	    	else
	    		newID=$((`tail -n 1 $todoFile | cut -d "[" -f2 | cut -d "]" -f1` + 1)) 
	    		echo " [$newID] $2" >> $todoFile
	    	fi
	    ;;
	    do)
	    	sed -i "s/$todoSymbol \[$2\]/$doneSymbol \[$2\]/g" $todoFile
	    ;;
	    undo)
	    	sed -i "s/$doneSymbol \[$2\]/$todoSymbol \[$2\]/g" $todoFile
	    ;;
	    edit)
	    	xdg-open $todoFile
	    ;;
	    notification)
	    	sendNotification
	    ;;
	esac
fi

