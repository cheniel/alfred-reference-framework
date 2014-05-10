#!/bin/bash
# used to handle argument responses

. arf/lib/common.sh

userQuery="$1"

# This file is used for results where validity is set to yes and the
# argument is specified. When one of these types of results is selected,
# this script is called to handle it.