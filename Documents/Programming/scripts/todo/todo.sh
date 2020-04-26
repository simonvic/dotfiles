#!/bin/zsh 
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

todoFile=~/Documents/Programming/scripts/todo/todo.txt
doneSymbol=
todoSymbol=
deletedSymbol=﫧

# Notification settings

icon=" "

#	Default urgency level [Available: low, normal, critical]
urgency=normal

#	For how much milliseconds the notification will stay visible
timeout=60000

#	Unique dunst notification id
uid=2597

########################################

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
		
	# Query commands
	list	[done|todo|deleted]	[name]	List with filters
		done		List things done
		todo		List things still to do
		deleted	List things cancelled
	
	# Edit commands
	new	<name>		Add a new thing to do with name <name>
	do	<id>		Mark it done
	undo	<id>		Mark it undone
	delete	<id>	Mark it deleted
	edit	Edit manually the todo list
	
	#Other
	notification	show todo list in a notification
"
}

function getCount() {
	case $1 in
		done)
			grep -e "$doneSymbol" $todoFile | grep "$2" | wc -l
		;;
		todo)
			grep -e "$todoSymbol" $todoFile | grep "$2" | wc -l
		;;
		deleted)
			grep -e "$deletedSymbol" $todoFile | grep "$2" | wc -l
		;;
		*)
			grep -e "$1" $todoFile | wc -l
		;;
	esac
}

function list() {
	case $1 in
		done)
			grep -e "$doneSymbol" $todoFile | grep "$2"
		;;
		todo)
			grep -e "$todoSymbol" $todoFile | grep "$2"
		;;
		deleted)
			grep -e "$deletedSymbol" $todoFile | grep "$2"
		;;
		*)
			grep -e "$1" $todoFile
		;;
	esac
}

function addNew() {
	if [ -z "$1" ]; then
		printUsage;	    	
	else
		newID=$((`tail -n 1 $todoFile | cut -d "[" -f2 | cut -d "]" -f1` + 1)) 
		echo "$todoSymbol [$newID] $1" >> $todoFile
	fi
}


function mark() {
	if [ -z "$2" ]; then
		printUsage
	else
		case $1 in
			done)
				sed -i "s/^\($deletedSymbol\|$todoSymbol\) \[$2\]/$doneSymbol \[$2\]/g" $todoFile
			;;
			todo)
				sed -i "s/^\($deletedSymbol\|$doneSymbol\) \[$2\]/$todoSymbol \[$2\]/g" $todoFile
			;;
			deleted)
				sed -i "s/^\($todoSymbol\|$doneSymbol\) \[$2\]/$deletedSymbol \[$2\]/g" $todoFile
			;;
			*)
				printUsage
			;;
		esac
	fi
}

function editFile() {
	xdg-open $todoFile &
}


function buildBar {
	$HOME/.config/i3/scripts/drawBar.sh $1 $2 $3
}

function sendNotification() {
	doneCount=`getCount done`
	todoCount=`getCount todo`
	deletedCount=`getCount deleted`
	totalCount=`getCount`
	todoPercent=$((todoCount * 100 / doneCount))
	
	summary="$todoCount todo | $doneCount done | $deletedCount deleted"
	body="
<small>`list todo`</small>

`buildBar 5 $todoPercent false` $todoPercent%
<b>$todoSymbol $todoCount</b> todo <b>│</b> <b>$doneSymbol $doneCount</b> done <b>│</b> <b>$deletedSymbol $deletedCount</b> deleted <b>│</b> <b> $totalCount</b> total
"
	
	case $(dunstify -a "simonvic.TODO" -A "listAll,  List all" -A "listDone,  List done" -A "listTodo,  List to do" -A "listDeleted,  List deleted" -A "todoHelp,  TODO help" -A "edit,  Edit the todo list" -i "$icon" -t "$timeout" -r "$uid" -u "$urgency" "$summary" "$body") in
		edit)
			editFile
		;;
		listAll)
			/usr/bin/rofi-sensible-terminal -e "$HOME/Documents/Programming/scripts/todo/todo.sh list" --hold
		;;
		listDone)
			/usr/bin/rofi-sensible-terminal -e "$HOME/Documents/Programming/scripts/todo/todo.sh list done" --hold
		;;
		listTodo)
			/usr/bin/rofi-sensible-terminal -e "$HOME/Documents/Programming/scripts/todo/todo.sh list todo" --hold
		;;
		listDeleted)
			/usr/bin/rofi-sensible-terminal -e "$HOME/Documents/Programming/scripts/todo/todo.sh list deleted" --hold
		;;
		todoHelp)
			/usr/bin/rofi-sensible-terminal -e "$HOME/Documents/Programming/scripts/todo/todo.sh help" --hold
		;;
	esac
}

case $1 in
# Query
	list)
		printHeader
		list $2 $3
	;;
	count)
		getCount $2 $3
	;;
# Edit
	new)
		addNew $2
	;;
	do)
		mark done $2
	;;
	undo)
		mark todo $2
	;;
	delete)
		mark deleted $2
	;;
	edit)
		editFile
	;;
# Other
	notification)
		sendNotification
	;;
	help)
		printHeader
		printUsage
	;;
	*)
		printHeader
		list todo
	;;
esac
