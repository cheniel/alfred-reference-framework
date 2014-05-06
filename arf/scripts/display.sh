#!/bin/bash
# given a type of tea, displays the information about the tea
# the query will be the argument passed to it by alfredTeaSearch.
# arguments:
# 	[line to parse] [data file] 

. arf/lib/workflowHandler.sh
. arf/lib/common.sh
. arf/lib/arf+.sh

displayData() {

	data=${1#$ESCAPE_STRING}

	# get the number of fields before $REPONSE_STRING
	numberOfFields=`grep -o $DELIMITER <<< \`echo "$1" | sed "s/${RESPONSE_STRING}.*//"\` | wc -l`

	# save the names of the fields into an array
	if [ ${#names[@]} -eq 0 ]; then # check to see if arf+ has already made it
		# get the first line
		nameLine=`sed '1q;d' $2`
		for i in $(seq 1 $numberOfFields); do 
			names[$i]=`echo $nameLine | cut -d $DELIMITER -f$i`
		done	
	fi

	if [ ${#icons[@]} -eq 0 ]; then
		# get the second line
		iconsLine=`sed '2q;d' $2`

		# save the images to use for each field into an array
		for i in $(seq 1 $numberOfFields); do 
			icons[$i]=`echo $iconsLine | cut -d $DELIMITER -f$i`
		done
	fi

	if [ ${#valid[@]} -eq 0 ]; then
		# get the third line
		validLine=`sed '3q;d' $2`
		for i in $(seq 1 $numberOfFields); do 
			valid[$i]=`echo $validLine | cut -d $DELIMITER -f$i`
		done
	fi

	if [ ${#autocomplete[@]} -eq 0 ]; then
		# get the fourth line
		autocompleteLine=`sed '4q;d' $2`
		for i in $(seq 1 $numberOfFields); do 
			autocomplete[$i]=`echo $autocompleteLine | cut -d $DELIMITER -f$i`
		done
	fi

	if [ ${#argument[@]} -eq 0 ]; then
		# get the fifth line
		argumentLine=`sed '5q;d' $2`
		for i in $(seq 1 $numberOfFields); do 
			argument[$i]=`echo $argumentLine | cut -d $DELIMITER -f$i`
		done
	fi

	# add results
	for i in $(seq 1 $numberOfFields); do 

		# get the data that needs to be presented
		dataString=`echo $data | cut -d $DELIMITER -f$i`

		# check autocomplete value, fill in
		if [[ ${autocomplete[i]} == "no" ]]; then
			autocompleteString="$1"
		else
			autocompleteString=${autocomplete[i]}
		fi

		# get icon
		if [ -f "arf/img/f$i/$dataString.png" ]; then
			iconString="arf/img/f$i/$dataString.png" 
		elif [ -f "arf/img/f$i/$dataString.gif" ]; then
			iconString="arf/img/f$i/$dataString.gif" 
		elif [ -f "arf/img/f$i/$dataString.jpeg" ]; then
			iconString="arf/img/f$i/$dataString.jpeg" 
		elif [ -f "arf/img/f$i/$dataString.jpg" ]; then
			iconString="arf/img/f$i/$dataString.jpg" 
		else
			iconString=${icons[$i]}
		fi

		addResult "${argument[$i]}" "$dataString" "${names[$i]}" "$iconString" "${valid[$i]}" "$autocompleteString"
	done

	addResult "" "Go back" "" "arf/img/sys/back.png" "no" "`echo $data | sed "s/.*${RESPONSE_STRING}//"`"
}


