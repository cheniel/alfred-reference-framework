#!/bin/bash
# using users input, finds the matching results

. arf/lib/common.sh

MAX_RESULTS=20

# check to see if the response file exists
if [ ! -f "$1" ]; then
	addResult "" "The response file, $1 does not exist." "Make sure the response file is valid" "icon.png" "no" ""
else
	query=`echo $2 | tr '[:upper:]' '[:lower:]'`
	queriesFound=0

	lineNumber=1 # allows for the skipping of the first two lines, which are the format and the icons

	# loop through the lines of the response file
	while read -r line; do

		if [ $lineNumber -gt 5 ]; then

			# get the name of the line
			value=`echo $line | cut -d $DELIMITER -f1`

			# convert to lowercase
			valueSearch=`echo "$value" | tr '[:upper:]' '[:lower:]'`

			if [[ ( $2 == "all" && ${#value} -gt 0 ) || $valueSearch == *$query* || $teaTypeSearch == *$query* ]]; then
				
				# get icon
				if [ -f "arf/img/f1/$value.png" ]; then
					iconString="arf/img/f1/$value.png" 
				elif [ -f "arf/img/f1/$value.gif" ]; then
					iconString="arf/img/f1/$value.gif" 
				elif [ -f "arf/img/f1/$value.jpeg" ]; then
					iconString="arf/img/f1/$value.jpeg" 
				elif [ -f "arf/img/f1/$value.jpg" ]; then
					iconString="arf/img/f1/$value.jpg" 
				else
					iconString=${icons[$i]}
				fi

				# add result to alfred, argument should be the entire line
				addResult "$line" "$value" "Get details" "$iconString" "no" "$ESCAPE_STRING$line$DELIMITER$RESPONSE_STRING$2$PREF_STRING$1"

				# increment the number of results found
				let "queriesFound=queriesFound+1"

				if [ $queriesFound -ge $MAX_RESULTS ]; then
					break
				fi
			fi

		else # increment line number
			let "lineNumber=lineNumber+1"
		fi

	done < $1

	# if no results were found
	if [ $queriesFound -eq 0 ]; then
		addResult "" "No results were found for $query" "Check reference file for item" "icon.png" "no" ""
	fi
fi
	
getXMLResults # return XML to alfred







