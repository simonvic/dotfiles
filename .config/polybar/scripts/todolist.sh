#TO-DO optimization
while true; do
	text=$(cat $HOME/Documents/Programming/scripts/todo/todo.txt | grep  | sed -e ':a;N;$!ba;s/\n/      /g')
	totalChar=$(wc -c $HOME/Documents/Programming/scripts/todo/todo.txt | cut -d " " -f1 )
	charToShow=$totalChar
	for i in $(seq $totalChar)
	do
		echo "TO-DO: ${text:$i:$charToShow}"
		sleep 1
	done
done
