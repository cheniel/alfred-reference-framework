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

touch "$pref" # create new

declare -a names
declare -a icons
declare -a valid
declare -a autocomplete
declare -a argument

###############################################################################
#                                FUNCTIONS                                    #                            
###############################################################################

# first arg should be the users search query
# Add data
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
				iconString=${icons[$i]}
			fi

			# add result to alfred, argument should be the entire line
			addResult "$line" "$2" "Get details" "$iconString" "no" "$ESCAPE_STRING$line$RESPONSE_STRING$2$PREF_STRING$pref"

		else
			addResult "" "ARF+ Error. Enter for details." "Wrong number of parameters provided to addData ($# vs $correctNargs)" "arf/img/sys/error.png" "no" "@args=$line"	
		fi

	else
		addResult "" "ARF+ Error. Enter for details." "addData() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
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

# For inputting icons
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

# For inputting valid attribute
setValidity() {

	# Check that setFieldNames has been called
	if [ $numberOfFields -gt 0 ]; then

		# Loop through all the fields
		i=0
		while [ $i -lt $numberOfFields ]; do

			# check that the argument does not exist
			if [ $# -eq 0 ]; then
				addResult "" "ARF+ Error. Enter for details." "Not enough parameters given to setValidity() (need $numberOfFields)" "arf/img/sys/error.png" "no" ""	
			else
				valid[i]="${!i}" # set the icon based on parameter
			fi

			let "i=i+1"
		done
	else
		addResult "" "ARF+ Error. Enter for details." "setValidity() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
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
				addResult "" "ARF+ Error. Enter for details." "Not enough parameters given to setAutocomplete() (need $numberOfFields)" "arf/img/sys/error.png" "no" ""	
			else
				autocomplete[i]="${!i}" # set the icon based on parameter
			fi
		
			let "i=i+1"
		done
	else
		addResult "" "ARF+ Error. Enter for details." "setAutocomplete() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
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
				addResult "" "ARF+ Error. Enter for details." "Not enough parameters given to setArguments() (need $numberOfFields)" "arf/img/sys/error.png" "no" ""	
			else
				argument[i]="${!i}" # set the icon based on parameter
			fi

			let "i=i+1"
		done
	else
		addResult "" "ARF+ Error. Enter for details." "setArguments() called before setFieldNames()" "arf/img/sys/error.png" "no" ""	
	fi

}

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

printNoResult() {
	if [ $numberOfResults == 0 ]; then
		addResult "" "No results were found" "Check reference file for item" "arf/img/sys/arf/img/sys/error.png" "no" ""
	fi
}

# Cleans up strings for compatibility with Alfred XML
# Remove < >, '
# Replace ! with .
# Find out what other characters need to be removed.
tidy() {
	echo `echo $1 | sed "s/[<>']//" | sed "s/!/./"`
}


