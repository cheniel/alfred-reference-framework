#!/bin/bash
# main.sh
# Part of the Alfred Reference Framework (ARF)
#
# Calls the correct shell script given alfred input.
#

# import display function
. arf/scripts/display.sh
. arf/lib/common.sh

# check for escape string to display data
if [[ $2 == *$ESCAPE_STRING* ]]; then
	displayData "$2" "$1"
	getXMLResults

# run on dynamic mode
elif [ "$3" != "--static" ]; then
	echo `./arf/dynamic.sh "$1" "$2"` 	# Populate data using dynamic.sh and ARF+

# run on static mode
else
	echo `./arf/scripts/search.sh "$1" "$2"`	# Use default.arf to get data
fi