#!/bin/bash

# ------------------------------------------------------------------------------
# Function iAmRoot
#
# Checks if the user running this function is root.
#
#
# Examples
# ========
# Runs `ls -al /` only if root :
#
#   iAmRoot && ls -al
#
# Same as above :
#
#   if ( $(iAmRoot) )
#   then
#       ls -al /
#   fi
#
# Runs foo function only if root :
#
#   function foo()
#   {
#        # do something that requires root.
#   }
#   iAmRoot && foo
#
# Same as above, with an error message :
#
#   iAmRoot && foo || printf "%s\n" "foo must be run as root. Aborting"
#
# ------------------------------------------------------------------------------

function iAmRoot()
{
    [[ $EUID -eq 0 ]] && return $?
}

readonly -f iAmRoot

#EOF