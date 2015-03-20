#!/bin/bash

# ------------------------------------------------------------------------------
# Function forAllSubdirs
#
# Invokes the given command for each directory in the given path.
#
#
# Parameters
# ==========
# directory : Required  : Parent directory.
# command   : Optional  : Command to execute. Can be a function or a built-in 
#                         command with options.
#                         If omitted, defaults to `echo`.
#
#
# Examples
# ========
# Lists non-hidden directories contained in /Users :
#
#   forAllSubdirs --nohidden "/Users"
#
# Invokes `ls -al` on all subdirectories of /Users :
#
#   forAllSubdirs "/Users" "ls -al"
#
# Same as above, with a user-defined function :
#
#   function list()
#   {
#        ls -al "$1"
#   }
#   forAllSubdirs "/Users" "list"
#
# ------------------------------------------------------------------------------

function forAllSubdirs()
{
#Usage
read -r -d '' usage <<-'END_USAGE'
usage: forAllSubdirs directory [command]
END_USAGE


    local cmd="echo"

    # Checks
    [[ $# -gt 0 ]] || { printf "%s\n" "$usage"; return 1; }

    # Job
    # See http://mywiki.wooledge.org/BashFAQ/001
    parent="$1"
    shift
    
    [[ $# -ne 0 ]] && cmd="$1"

    find "$parent" -type d -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d '' line
    do
        $cmd "$line"
    done
}

readonly -f forAllSubdirs

#EOF