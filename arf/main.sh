#!/bin/bash
# main.sh
# Part of the Alfred Reference Framework (ARF)
#
# Calls the correct shell script given alfred input.
#

if [ "$3" != "--static" ]; then
	echo `./arf/dynamic.sh "$1" "$2"` 	# Populate data using dynamic.sh and ARF+
else
	echo `./arf/scripts/search.sh "$1" "$2"`	# Use default.arf to get data
fi