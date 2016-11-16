#!/bin/bash

# ------------------------------------------------------------------------------
# Function trusting
#
# Retrieves a bash script from the given URL, save it in a temp file and source 
# it.
#
# This is especially useful when your script requires some functions that are  
# stored in another file.
#
# WARNING: USE WITH EXTREME CAUTION !!!
# ONLY USE THIS FUNCTION WITH TRUSTED SOURCES / URLs.
#
#
# Parameters
# ==========
# url (Req) :
#     URL of the file to source.
#
# Examples
# ========
# Import the OS.sh function directly from github so we can use the 
# `isSnowLeopard` function :
#
#   trusting "https://raw.githubusercontent.com/Frzk/functions/master/OS.sh"
#   isSnowLeopard && printf "Snow Leopard ? %s" "OK"
#   stop_trusting
#
# ------------------------------------------------------------------------------

function trusting()
{
#Usage
read -r -d '' usage <<-'END_USAGE'
usage: trusting url
END_USAGE


    local prog
    prog=$(basename "${0}")

    src=$(mktemp -t "${prog}")
    curl -s -o "${src}" "${1}"

    source "${src}" 

    imp+=("${src}")
}

# ------------------------------------------------------------------------------
# Function stop_trusting
#
# Removes files that where previously imported with `trusting()`.
#
# Note: This only removes the temporary files. It doesn't restore the
#       environnement and imported functions are still available after.
#
# WARNING: USE WITH EXTREME CAUTION !!!
#
# Internally, the function loops through an array called `imp` and deletes the
# files referenced in this array.
#
# Options
# =======
# --dontAsk (Opt) :
#     Don't prompt user before removing the files.
# 
# Examples
# ========
# Import the OS.sh function directly from github so we can use the 
# `isSnowLeopard` function :
#
#   trusting "https://raw.githubusercontent.com/Frzk/functions/master/OS.sh"
#   isSnowLeopard && printf "Snow Leopard ? %s" "OK"
#   stop_trusting
#
# ------------------------------------------------------------------------------

function stop_trusting()
{
#Usage
read -r -d '' usage <<-'END_USAGE'
usage: stop_trusting [--dontAsk]
END_USAGE

    local reply="n"

    if [ "${#}" -gt 0 ]
    then
        if [ "${1}" = "--dontAsk" ]
        then
            reply="y"
        fi
    fi
    
    if [[ "${reply}" == "n" ]]
    then
        printf "I will remove these files :\n"
        for s in "${imp[@]}"
        do
            printf "  %s\n" "${s}"
        done
        
        read -r -n 1 -p "Are you sure ? " reply
    fi

    if [[ "${reply}" =~ ^[Yy]$ ]]
    then
        for s in "${imp[@]}"
        do
            rm "${s}"
        done

        unset imp
    fi
}

readonly -f trusting
readonly -f stop_trusting

#EOF
