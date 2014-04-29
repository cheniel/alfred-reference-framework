#!/bin/bash
#
# main.sh
# Part of the Alfred Reference Framework (ARF)
#
# Calls the correct shell script given alfred input.
#

if [ "$3" == "--dynamic" ]; then
	echo `./arf/scripts/dynamic.sh "$1" "$2"` 	# ARF+. Create dynamic data
else
	echo `./arf/scripts/search.sh "$1" "$2"`	# ARF. Use default.arf
fi