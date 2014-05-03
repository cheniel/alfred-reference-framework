#!/bin/bash
# given a type of tea, displays the information about the tea
# the query will be the argument passed to it by alfredTeaSearch.
# arguments:
# 	[line to parse] [data file] [escape string]

. arf/lib/workflowHandler.sh

displayData() {

	data=${1#$3}

	# get the number of fields before -_rsp_-
	numberOfFields=`grep -o ":" <<< \`echo "$1" | sed 's/-_rsp_-.*//'\` | wc -l`

	# get the first line
	nameLine=`sed '1q;d' $2`
	
	# save the names of the fields into an array
	for i in $(seq 1 $numberOfFields); do 
		names[$i]=`echo $nameLine | cut -d ':' -f$i`
	done

	# get the second line
	iconsLine=`sed '2q;d' $2`

	# save the images to use for each field into an array
	for i in $(seq 1 $numberOfFields); do 
		icons[$i]=`echo $iconsLine | cut -d ':' -f$i`
	done

	# get the third line
	validLine=`sed '3q;d' $2`

	for i in $(seq 1 $numberOfFields); do 
		valid[$i]=`echo $validLine | cut -d ':' -f$i`
	done

	# get the fourth line
	autocompleteLine=`sed '4q;d' $2`

	for i in $(seq 1 $numberOfFields); do 
		autocomplete[$i]=`echo $autocompleteLine | cut -d ':' -f$i`
	done

	# get the fifth line
	argumentLine=`sed '5q;d' $2`
	for i in $(seq 1 $numberOfFields); do 
		argument[$i]=`echo $argumentLine | cut -d ':' -f$i`
	done

	# add results
	for i in $(seq 1 $numberOfFields); do 

		# get the data that needs to be presented
		dataString=`echo $data | cut -d ':' -f$i`

		# check autocomplete value, fill in
		if [ ${autocomplete[i]} == "no" ]; then
			autocompleteString="$1"
		else
			autocompleteString=${autocomplete[i]}
		fi

		# see if a non-default value should be used.
		#files=$(ls "arf/img/f$i/$dataString*" 2> /dev/null | wc -l)
		#if [ "$files" != "0" ]; then
		#	echo "exist"
		#else
		#	echo "doesn't exist"
		#fi

		if [ -f "arf/img/f$i/$dataString.png" ]; then
			iconString="arf/img/f$i/$dataString.png" # TODO currently only works with .png files
		else
			iconString=${icons[$i]}
		fi

		addResult "${argument[$i]}" "$dataString" "${names[$i]}" "$iconString" "${valid[$i]}" "$autocompleteString"
	done

	addResult "" "Go back" "" "arf/img/sys/back.png" "no" "`echo $data | sed 's/.*\-_rsp_-//'`"

}


