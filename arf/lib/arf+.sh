#!/bin/bash
# arf+.sh
# Part of the Alfred Reference Framework
#
# Library for dynamic.sh used to create results
# Part of ARF+, which generate dynamic data to be displayed in Alfred 2.
# 

. arf/lib/workflowHandler.sh	# Handles XML
escapeString="-_arf_-" 


numberOfFields=0
# currentLine=1

# first arg should be the users search query
# Add data
addData() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Check that the user provided the right number of arguments
		if [ $numberOfFields -eq $# ]; then

			# create line


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
			addResult "$line" "$1" "Get details" "$iconString" "no" "$escapeString$line!-_rsp_-$2"

		else
			addResult "" "ARF+ Error" "Wrong number of parameters provided to addData ($numberOfFields vs $#)" "error.png" "no" ""	
		fi

	else
		addResult "" "ARF+ Error" "addData() called before setFieldNames()" "error.png" "no" ""	
	fi

}

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
			let "i=i+1"
		done

		# set default validity
		i=0
		while [ $i -lt $numberOfFields ]; do
			valid[i]="no"
			let "i=i+1"
		done

		# set default autocomplete attribute
		i=0
		while [ $i -lt $numberOfFields ]; do
			autocomplete[i]="no"
			let "i=i+1"
		done

		# set default argument attribute
		i=0
		while [ $i -lt $numberOfFields ]; do
			argument[i]=""
			let "i=i+1"
		done

	else
		addResult "" "ARF+ Error" "setFieldNames() received no arguments" "error.png" "no" ""
	fi
}

# For inputting icons
setIcons() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error" "Not enough parameters given to setIcons() (need $numberOfFields)" "error.png" "no" ""	
			else
				icons[i]="${!i}" # set the icon based on parameter
			fi

		let "i=i+1"
		done
	else
		addResult "" "ARF+ Error" "setIcons() called before setFieldNames()" "error.png" "no" ""	
	fi
}

# For inputting valid attribute
setValidity() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error" "Not enough parameters given to setValidity() (need $numberOfFields)" "error.png" "no" ""	
			else
				valid[i]="${!i}" # set the icon based on parameter
			fi

		let "i=i+1"
		done
	else
		addResult "" "ARF+ Error" "setValidity() called before setFieldNames()" "error.png" "no" ""	
	fi

}

# For inputting autocomplete attribute
setAutocomplete() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error" "Not enough parameters given to setAutocomplete() (need $numberOfFields)" "error.png" "no" ""	
			else
				autocomplete[i]="${!i}" # set the icon based on parameter
			fi
		
		let "i=i+1"
		done
	else
		addResult "" "ARF+ Error" "setAutocomplete() called before setFieldNames()" "error.png" "no" ""	
	fi

}

# For inputting argument attribute
setArguments() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error" "Not enough parameters given to setArguments() (need $numberOfFields)" "error.png" "no" ""	
			else
				argument[i]="${!i}" # set the icon based on parameter
			fi

		let "i=i+1"
		done
	else
		addResult "" "ARF+ Error" "setArguments() called before setFieldNames()" "error.png" "no" ""	
	fi

}


# Use to finish off preferences
# Not necessary due to design change
# establishPreferences() {

	# add field names

#	let "currentLine=currentLine+1"


	# add icon names

#	let "currentLine=currentLine+1"	


	# add valid attributes

#	let "currentLine=currentLine+1"


	# add autcomplete attributes

#	let "currentLine=currentLine+1"	


	# add argument attributes

#	let "currentLine=currentLine+1"	
#}

# Cleans up strings for compatibility with Alfred XML
# Remove < >, '
# Replace ! with .
# Find out what other characters need to be removed.
tidy() {
	echo `echo $1 | sed "s/[<>']//" | sed "s/!/./"`
}


