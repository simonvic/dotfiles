todoFile=~/Documents/scripts/todo/todo.txt
doneSymbol=
todoSymbol=

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
	list	[filter]	List things to do with a filter
	done		List things done
	undone	List things to do if any
	new	<name>		Add a new thing to do with name <name>
	do	<name>		Mark it done
	undo	<name>		Mark it undone
"
}

if [ -z "$1" ]
then
	printHeader;
	printUsage;
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
	    	cat $todoFile | grep 
	    ;;
	    undone)
	    	thingsUndone=`grep -c -e  $todoFile`;
	    	if [ $thingsUndone -ge 1 ]
	    	then
				printHeader;
  		    	cat $todoFile | grep 
  		   fi
	    ;;
	    new)
	    	echo " $2" >> $todoFile
	    ;;
	    do)
	    	sed -i "s/ $2/ $2/g" $todoFile
	    ;;
	    undo)
	    	sed -i "s/ $2/ $2/g" $todoFile
	    ;;
	esac
fi

