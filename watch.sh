#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Function watch
#
# Invokes the given command every n seconds.
#
#
# Parameters
# ==========
# command (Req) :
#     Command to execute.
#
# everyNbSec (Opt) :
#     Defaults to 1.
#
#
# Examples
# ========
# Count the number of UDP sockets open every 5 minutes:
#
#   watch "lsof -i udp | wc -l | tr -d ' '" 300
#
# ------------------------------------------------------------------------------


function watch()
{
#Usage
read -r -d '' usage <<-'END_USAGE'
usage: watch command [everyNbSec]
END_USAGE

    local waitFor=1
    local cmd="${1}"
    shift

    [[ $# -ne 0 ]] && waitFor="${1}"
    shift

    while :
    do
        date
        bash -c "${cmd}"
        sleep "${waitFor}"
    done
}

readonly -f watch

#EOF
