#!/bin/bash
# arf+.sh
# Part of the Alfred Reference Framework
#
# Library for dynamic.sh used to create the temporary .arf file 
# Part of ARF+, which generate dynamic data to be displayed in Alfred 2.
# 

numberOfFields=0
currentLine=1

# For inputting value names (mandatory)
setFieldNames() {
	# requires at least one argument

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
tidy() {

}


