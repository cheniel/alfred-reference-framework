#!/bin/bash
# dynamic.sh
# Part of the Alfred Reference Framework
#
# Modified by __________ for the _________ Alfred Workflow
#
# Description: Used to create results from dynamic data
# 
# Part of ARF+, which generate dynamic data to be displayed in Alfred 2.
#
# Parameters:[default static .arf][user input]
#
# Make sure that the script filter has the "--dynamic" option enabled

# Libaries
. arf/lib/arf+.sh				# ARF+ Libary

# Arguments
defaultARF="$1"
userInput="$2"

###############################################################################
#                           MODIFY BELOW THIS LINE                            #
###############################################################################
# Set preferences (analogousfirst five lines of .arf)

# SET UP FIELD NAMES
# Always begin with setting up field names. All field names must have an
# argument name in this function call, as this function is also the basis of
# how many fields will be used in the file.
setFieldNames "Name" "Birthday" "Gender"

# SET UP OTHER FOUR PREFERENCES
# These four are optional. Go ahead and delete their calls if you don't want 
# to use them. They were defined to their default values when setFieldNames 
# was called

# default: "icon.png" "icon.png" ... "icon.png"
setIcons "icon.png" "arf/img/f2/cake.png" "icon.png" 				
				# default sets all to no
				# default sets all to no
				# default leaves blank



# SOLIDIFY PREFERENCES
# Don't remove this. Just call it once you've set your preferences
# and before you begin to add data.
establishPreferences



# ADD DATA
# Do this however you like. Here are some examples.
# Base the information you display on the users query, 
#		when working with ARF+, EVERY CALL to addData WILL APPEAR on the 
#		Alfred results.
# Always make first argument the user's input.

# EX. 1: Just add a single lines if the user inputs...
# try it out by typing "arf cah" in Alfred.
if [ "$userInput" == "cah" ]; then
	addData "$userInput" "Calvin" "November 18, 1985" "Male"
	addData "$userInput" "Hobbes" "November 18, 1985" "Male"
	addData "$userInput" "Bill" "July 5, 1958" "Male"
fi



# EX. 2: Retrieve information from elsewhere and parse it
# This example pulls information about the files on ~/Documents
# try it out by typing "arf desk" in Alfred.

# Pull the information from the desktop
if [ "$userInput" == "doc" ]; then
	desktopFiles=`ls -l ~/Documents | sed -n '1!p'`

	# For each file (line) in the string
	while read -r line; do

		# Get the file name
		filename=`echo $line | cut -d ' ' -f9,10,11,12,13,14` # assumes < 6 spaces

		# Get the date it was created
		filedate=`echo $line | cut -d ' ' -f6,7,8`

		# Get the file type
		filetype=`echo $line | cut -d ' ' -f1 | sed "s/@//"` # removes @

		# add Data
		addData "$userInput" "$filename" "$filedate" "$filetype" 

	done <<< "$desktopFiles"
fi




# other ideas: 
# 	- curl webpages and parse the data

# advice and warnings for adding data:
# 	- single quotes, "<", ">", and other characters that pose problems with XML
#	  will pose problems in Alfred as well. ARF+ will handle a good amount of 
#	  errors such as these by substituting characters, so using these characters
#	  could result in unexpected behavior--e.g. colons will be converted
#	  to dashes.
# 	- Don't over populate the data. Remember -- Alfred only gives you 20 
#	  reponses per search. That's a good place to cut it adding data to
#	  reduce runtime.

### OPTIONAL 
# set the error message that is displayed
# default is "No results were found" "Try another search"
setError "No results were found" "Try either {arf cah} or {arf doc}"

###############################################################################
#                           MODIFY ABOVE THIS LINE                            #
###############################################################################
# Call search using dynamic.arf. removed because of design change
# echo `./arf/scripts/search.sh "$data" "$userInput"`
pushData

