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
. arf/lib/workflowHandler.sh	# Handles XML

# Arguments
defaultARF="$1"
userInput="$2"
bundleID=`getBundleId`
dataDirectory="$VPREFS$bundleID/"
data="$dataDirectory/dynamic.arf"

##### PROBABLY WILL REMOVE (generating temp .arf is unnecessary overhead)
# Check and creation of volatile data folder
if [ ! -d "$dataDirectory" ]; then
	mkdir "$dataDirectory"
fi

# Check and reset of dynamic.arf
if [ -f "$data" ]; then
	rm -f "$data" # deletion of old
fi

touch "$data" # create new
#####

##### DON'T DELETE THIS
# check user input for escapeString
# if it contains it, defer responsibilities to display.sh
# maybe do this in main?

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
				# default sets all to no
				# default sets all to no
				# default leaves blank

# SOLIDIFY PREFERENCES
# Don't mess with this. Just call it once you've set your preferences
# and before you begin to add data.
# establishPreferences "$data"

# ADD DATA
# Do this however you like. Here are some examples.
# Always make first argument the user's input.

# EX. 1: Just add a single lines if the user inputs...

addData "$userInput" "Calvin" "November 18, 1985" "Male"
addData "$userInput" "Bill" "July 5, 1958" "Male"
addData "$userInput" "Hobbes" "November 18, 1985" "Male"

# EX. 2: Retrieve information from elsewhere and parse it
# This example pulls information about the files on your desktop 
# and populates the same list. Hope it's clean!

# Pull the information from the desktop

# For each file
	# Get the file name
	# Get the date it was created
	# Get the file type

	# add Data


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

###############################################################################
#                           MODIFY ABOVE THIS LINE                            #
###############################################################################
# Call search using dynamic.arf. removed because of design change
# echo `./arf/scripts/search.sh "$data" "$userInput"`
getXMLResults


