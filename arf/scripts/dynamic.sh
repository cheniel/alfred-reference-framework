#!/bin/bash
# dynamic.sh
# Part of the Alfred Reference Framework
#
# Modified by __________ for the _________ Alfred Workflow
#
# Description: Used to create the temporary .arf file from dynamic data
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

# Check and creation of volatile data folder
if [ ! -d "$dataDirectory" ]; then
	mkdir "$dataDirectory"
fi

# Check and reset of dynamic.arf
if [ -f "$data" ]; then
	rm -f "$data" # deletion of old
fi

touch "$data" # create new

###############################################################################
#                           MODIFY BELOW THIS LINE                            #
###############################################################################
# Set preferences (first five lines of .arf)

# SET UP FIELD NAMES
# Always begin with setting up field names. All field names must have an
# argument name in this function call, as this function is also the basis of
# how many fields will be used in the file.
setFieldNames "Name" "Birthday" "Gender"

# SET UP OTHER FOUR PREFERENCES
# These four are optional. Go ahead and delete their calls if you don't want 
# to use them. They were defined to their default values when setFieldNames 
# was called
				# default: "field1.png" "field2.png" ... "fieldn.png"
				# default sets all to no
				# default sets all to no
				# default leaves blank

# SOLIDIFY PREFERENCES
# Don't mess with this. Just call it once you've set your preferences
# and before you begin to add data.
establishPreferences

# ADD DATA
# Do this however you like. Here are some examples.

# EX. 1: Just add a single lines
addData "Calvin" "November 18, 1985" "Male"
addData "Bill" "July 5, 1958" "Male"
addData "Hobbes" "November 18, 1985" "Male"

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
#	  will pose problems in ARF+ as well.
# 	- Don't over populate the data. Remember -- Alfred only gives you 20 
#	  reponses per search. That's a good place to cut it adding data to
#	  reduce runtime. DEV NOTE: Could potentially hard-set these limits to 
# 	  cause errors in the future. OR, add a result which jumps to the next 
# 	  20 reponses.

###############################################################################
#                           MODIFY ABOVE THIS LINE                            #
###############################################################################
# Call search using dynamic.arf
echo `./arf/scripts/search.sh "$data" "$userInput"`

