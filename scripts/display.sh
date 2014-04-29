#!/bin/bash
# given a type of tea, displays the information about the tea
# the query will be the argument passed to it by alfredTeaSearch.
# arguments:
# 	[line to parse] [data file] [escape string]

. lib/workflowHandler.sh

parseData() {

	data=${1#$3}

	# get the number of fields
	numberOfFields=`grep -o ":" <<<"$1" | wc -l`
	let "numberOfFields=numberOfFields+1"

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
	validLine=`sed '4q;d' $2`

	for i in $(seq 1 $numberOfFields); do 
		autocomplete[$i]=`echo $validLine | cut -d ':' -f$i`
	done

	# add results
	for i in $(seq 1 $numberOfFields); do 

		if [ ${autocomplete[i]} == "yes" ]; then
			autocompleteString=`echo $data | cut -d ':' -f2`
		else
			autocompleteString="$1"
		fi

		addResult "`echo $data | cut -d ':' -f$i`" "`echo $data | cut -d ':' -f$i`" "${names[$i]}" "${icons[$i]}" "${valid[$i]}" "$autocompleteString"
	
	done

}


