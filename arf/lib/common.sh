#!/bin/bash
# common.sh
# contains common variables 

. arf/lib/workflowHandler.sh

ESCAPE_STRING="-_arf_-" 
RESPONSE_STRING="-_rsp_-"
PREF_STRING="-_prf_-"
DELIMITER='!'

# generated from workflowHandler.sh
BUNDLE_ID=`getBundleId`
DATA_DIRECTORY="$VPREFS$bundleID/"
