#!/bin/bash
# using users input, finds the matching results

. lib/workflowHandler.sh # import workflow handler
. scripts/display.sh

escapeString="-----"

# check to see if the response file exists
if [ ! -f "$1" ]; then
	addResult "" "The response file, $2 does not exist." "Make sure the response file is valid" "icon.png" "no" ""
fi
	
# if the first part does not contain the escape string
if [[ $2 != *$escapeString* ]]; then

	query=`echo $2 | tr '[:upper:]' '[:lower:]'`
	queriesFound=0

	lineNumber=1 # allows for the skipping of the first two lines, which are the format and the icons

	# loop through the lines of the response file
	while read -r line; do

		if [ $lineNumber -gt 4 ]; then

			# if the query is found in the first part or second part of the line (delimited by :)
			value=`echo $line | cut -d ':' -f1`

			# convert to lowercase
			valueSearch=`echo "$value" | tr '[:upper:]' '[:lower:]'`

			if [[ ( $2 == "all" && ${#value} -gt 0 ) || $valueSearch == *$query* || $teaTypeSearch == *$query* ]]; then
				
				# add result to alfred, argument should be the entire line
				addResult "$line" "$value" "Get details" "icon.png" "no" "$escapeString$line:$2"

				# increment the number of results found
				let "queriesFound=queriesFound+1"
			fi

		else # increment line number
			let "lineNumber=lineNumber+1"
		fi

	done < $1

	# if no results were found
	if [ $queriesFound -eq 0 ]; then
		addResult "" "No results were found for $query" "Check reference file for item" "icon.png" "no" ""
	fi

else # the escape string was found
	parseData "$2" $1 $escapeString
fi


getXMLResults # return XML to alfred







