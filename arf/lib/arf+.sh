#!/bin/bash
# arf+.sh
# Part of the Alfred Reference Framework
#
# Library for dynamic.sh used to create results
# Part of ARF+, which generate dynamic data to be displayed in Alfred 2.
# 

. arf/lib/common.sh

numberOfFields=0
numberOfResults=0

prefFilename="preferences.arf"
pref="$DATA_DIRECTORY$prefFilename"

# Check and creation of volatile data folder for preferences
if [ ! -d "$DATA_DIRECTORY" ]; then
	mkdir "$DATA_DIRECTORY"
fi

# Check and reset of preferences.arf
if [ -f "$pref" ]; then
	rm -f "$pref" # deletion of old
fi

touch "$pref" # create new preference file

err1="No results were found"
err2="Try another search"

declare -a names
declare -a icons
declare -a valid
declare -a autocomplete
declare -a argument

###############################################################################
#                                FUNCTIONS                                    #                            
###############################################################################

# first arg should be the users search query
# Add data to be displayed in Alfred
# e.g.
# addData "$userInput" "Calvin" "November 18, 1985" "Male"
addData() {

	# create line. placed before checks for error messages
	line=""
	for i in "${@:2}"
	do
	    line="$line$i$DELIMITER"
	done

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		correctNargs=$(($numberOfFields+1))

		# Check that the user provided the right number of arguments
		if [ $correctNargs -eq $# ]; then

			# get icon
			if [ -f "arf/img/f1/$2.png" ]; then
				iconString="arf/img/f1/$2.png" 
			elif [ -f "arf/img/f1/$2.gif" ]; then
				iconString="arf/img/f1/$2.gif" 
			elif [ -f "arf/img/f1/$2.jpeg" ]; then
				iconString="arf/img/f1/$2.jpeg" 
			elif [ -f "arf/img/f1/$2.jpg" ]; then
				iconString="arf/img/f1/$2.jpg" 
			else
				iconString=${icons[0]}
			fi

			# add result to alfred, argument should be the entire line
			addResult "$line" "$2" "Get details" "$iconString" "no" "$ESCAPE_STRING$line$RESPONSE_STRING$1$PREF_STRING$pref"

		else
			addResult "" "ARF+ Error. Enter for details." "Wrong number of parameters provided to addData ($# vs $correctNargs)" "arf/img/sys/error.png" "no" "@args=$line. Make sure to put \$userInput as the first arg"	
		fi

	else
		addResult "" "ARF+ Error. Enter for details." "addData() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
	fi

	let "numberOfResults=numberOfResults+1"
}

# For inputting value names (mandatory)
# Arguments are FIELD1_TYPE, FIELD2_TYPE, FIELD3_TYPE...
# e.g.
# setFieldNames "Name" "Birthday" "Gender"
setFieldNames() {
	
	# requires at least one argument
	if [ $# -gt 0 ]; then

		numberOfFields=$#

		# set field names
		i=0
		for name in "$@"
		do
			names[$i]="$name"
			let "i=i+1"
		done

		# set default icons
		i=0
		while [ $i -lt $numberOfFields ]; do
			icons[$i]="icon.png"
			let "i=i+1"
		done

		# set default validity
		i=0
		while [ $i -lt $numberOfFields ]; do
			valid[$i]="no"
			let "i=i+1"
		done

		# set default autocomplete attribute
		i=0
		while [ $i -lt $numberOfFields ]; do
			autocomplete[$i]="no"
			let "i=i+1"
		done

		# set default argument attribute
		i=0
		while [ $i -lt $numberOfFields ]; do
			argument[$i]=""
			let "i=i+1"
		done

	else
		addResult "" "ARF+ Error. Enter for details." "setFieldNames() received no arguments" "arf/img/sys/error.png" "no" ""
	fi
}

# For inputting default icons for fields
# Arguments are FIELD1_ICON, FIELD2_ICON, FIELD3_ICON...
# Default is icon.png for all fields
# e.g.
# setIcons "arf/img/f1/default.png" "arf/img/f2/default.png" "arf/img/f3/default.png" ... 
setIcons() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		arg=1
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error. Enter for details." "Not enough parameters given to setIcons() (need $numberOfFields)" "arf/img/sys/error.png" "no" ""	
			else
				icons[i]="${!arg}" # set the icon based on parameter
			fi

			let "i=i+1"
			let "arg=arg+1"
		done
	else
		addResult "" "ARF+ Error. Enter for details." "setIcons() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
	fi
}

# For inputting validity for fields
# Arguments are FIELD1_VALIDITY, FIELD2_VALIDITY, FIELD3_VALIDITY...
# Default is "no" for all fields
# e.g.
# setValidity "no" "yes" "no"
setValidity() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		arg=1
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error. Enter for details." "Not enough parameters given to setValidity() (need $numberOfFields)" "arf/img/sys/error.png" "no" ""	
			else
				valid[i]="${!arg}" # set the icon based on parameter
			fi

			let "i=i+1"
			let "arg=arg+1"

		done
	else
		addResult "" "ARF+ Error. Enter for details." "setValidity() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
	fi

}

# For inputting autocomplete attribute
# When valid is no, Alfred uses the autocomplete attribute to modify the
# user's query to whatever autocomplete is specified as when the user
# selects the option.
#
# In ARF+, if "no" is used in autocomplete, selecting an item changes the 
# query to the current query, so nothing happens.
#
# Could be used to jump to specific searches from options.
#
# Arguments are FIELD1_AUTOCOMPLETE, FIELD2_AUTOCOMPLETE, FIELD3_AUTOCOMPLETE...
# Default is "no" for all fields
# e.g.
# setAutocomplete "no" "yes" "no"
setAutocomplete() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		arg=1
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error. Enter for details." "Not enough parameters given to setAutocomplete() (need $numberOfFields)" "arf/img/sys/error.png" "no" ""	
			else
				autocomplete[i]="${!arg}" # set the icon based on parameter
			fi
		
			let "i=i+1"
			let "arg=arg+1"
		done
	else
		addResult "" "ARF+ Error. Enter for details." "setAutocomplete() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
	fi

}

# For inputting argument attribute
# The argument is passed to actions.sh if validity for the field is 
# set to no.
# 
# Arguments are FIELD1_ARGUMENT, FIELD2_ARGUMENT, FIELD3_ARGUMENT...
# Default is "" for all fields
#
# e.g.
# setArguments "" "openHelp" "runScript"
setArguments() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		arg=0
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error. Enter for details." "Not enough parameters given to setArguments() (need $numberOfFields)" "arf/img/sys/error.png" "no" ""	
			else
				argument[i]="${!arg}" # set the icon based on parameter
			fi

			let "i=i+1"
			let "arg=arg+1"
		done
	else
		addResult "" "ARF+ Error. Enter for details." "setArguments() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
	fi

}

# Creates temporary preferences file out of the user-set fieldnames, icons
# validity, autocomplete, and arguments for each field.
#
# Call once after all preferences have been set
establishPreferences() {

	# add field names
	i=0
	while [ $i -lt $numberOfFields ]; do
		echo -n "${names[$i]}$DELIMITER" >> "$pref"
		let "i=i+1"
	done
	echo >> "$pref"

	# add icons
	i=0
	while [ $i -lt $numberOfFields ]; do
		echo -n "${icons[$i]}$DELIMITER" >> "$pref"
		let "i=i+1"
	done
	echo >> "$pref"

	# add validitys
	i=0
	while [ $i -lt $numberOfFields ]; do
		echo -n "${valid[$i]}$DELIMITER" >> "$pref"
		let "i=i+1"
	done
	echo >> "$pref"

	# add autocomplete attributes
	i=0
	while [ $i -lt $numberOfFields ]; do
		echo -n "${autocomplete[$i]}$DELIMITER" >> "$pref"
		let "i=i+1"
	done
	echo >> "$pref"

	# add argument attributes
	i=0
	while [ $i -lt $numberOfFields ]; do
		echo -n "${argument[$i]}$DELIMITER" >> "$pref"
		let "i=i+1"
	done
}

# Allows user to determine the error messages that are displayed is
# The user's search does not receive any results
# The first argument is the large text,
# The second argument is the smaller text.
#
#
# Default:
#	No results were found
#	Try another search
#
# e.g.
# setError "We couldn't find any results for that query." "Try again later."
setError() {
	if [ $# -ge 2 ]; then
		err1="$1"
		err2="$2"
	else
		addResult "" "ARF+ Error. Enter for details." "setError() received less than two arguments" "arf/img/sys/error.png" "no" ""
	fi
}

# User does not need to call this.
printNoResult() {
	if [ $numberOfResults == 0 ]; then
		addResult "" "$err1" "$err2" "arf/img/sys/error.png" "no" ""
	fi
}

# Cleans up strings for compatibility with Alfred XML
# Remove < >, '
# Replace ! with .
# Find out what other characters need to be removed.
tidy() {
	echo `echo $1 | sed "s/[<>']//" | sed "s/!/./"`
}

# needs to be called exactly once at the end of dynamic.sh
pushData() {
	printNoResult
	getXMLResults
}

