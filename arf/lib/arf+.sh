#!/bin/bash
# arf+.sh
# Part of the Alfred Reference Framework
#
# Library for dynamic.sh used to create results
# Part of ARF+, which generate dynamic data to be displayed in Alfred 2.
# 

. arf/lib/workflowHandler.sh	# Handles XML

numberOfFields=0
currentLine=1

# For inputting value names (mandatory)
setFieldNames() {
	
	# requires at least one argument
	if [ $# -gt 0 ]; then

		numberOfFields=$#

		# set field names
		i=0
		for name in "$@"
		do
			names[i]="$name"
			let "i=i+1"
		done

		# set default icons
		i=0
		while [ $i -lt $numberOfFields ]; do
			icons[i]="icon.png"
		done

		# set default validity
		i=0
		while [ $i -lt $numberOfFields ]; do
			valid[i]="no"
		done

		# set default autocomplete attribute
		i=0
		while [ $i -lt $numberOfFields ]; do
			autocomplete[i]="no"
		done

		# set default argument attribute
		i=0
		while [ $i -lt $numberOfFields ]; do
			argument[i]=""
		done

	else
		addResult "" "ARF+ Error" "setFieldNames() received no arguments" "error.png" "no" ""
	fi
}

# For inputting icons
setIcons() {

}

# For inputting valid attribute
setValidity() {

}

# For inputting autocomplete attribute
setAutocomplete() {

}

# For inputting argument attribute
setArguments() {

}

# Add data
addData() {
	# check current line

	let "currentLine=currentLine+1"
}

# Use to finish off preferences
establishPreferences() {

	# add field names

	let "currentLine=currentLine+1"


	# add icon names

	let "currentLine=currentLine+1"	


	# add valid attributes

	let "currentLine=currentLine+1"


	# add autcomplete attributes

	let "currentLine=currentLine+1"	


	# add argument attributes

	let "currentLine=currentLine+1"	
}

# Cleans up strings for compatibility with Alfred XML
# Remove !, < >, '
# Find out what other characters need to be removed.
tidy() {
	echo `echo $1 | sed "s/[!<>']//"`
}


