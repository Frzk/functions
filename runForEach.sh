#!/bin/bash

# ------------------------------------------------------------------------------
# Function runForEach
#
# Invokes the given command for each line in the given file.
# This is especially useful when you want to launch a command on a list of 
# hosts.
#
#
# Parameters
# ==========
# list_file (Req) :
#     File to read as input.
#     Each line will be passed to <command>, unless you specify the --field 
#     options.
#     Lines starting with a '#' and empty lines are skipped.
#
# command (Opt) :
#     Command to execute. Can be a function or a built-in command with options.
#     If omitted, defaults to `echo`.
#
#
# Options
# =======
# --field n (Opt) :
#     Allows user to specify which field to pass to <command>.
#     If lines contain several fields (delimited by tabs or multiple spaces), 
#     you can use this option to pass only one of these fields to <command>.
#     The first field is numbered 1.
#     If omitted, the whole line is given to <command>.
#
#
# Examples
# ========
# Considering the following 'hosts.txt' file :
#
#   cat ./hosts.txt
#   imac1   172.24.0.10 00:11:22:33:44:55
#   imac2   172.24.0.11 00:11:22:33:44:56
#   #macbook1    172.24.0.20 00:11:22:33:45:67
#   macbookpro2 172.24.0.30 00:11:22:33:45:89
#
# And the following function :
#
#   function getNetworkInfo()
#   {
#       # In this example, $1 is field n.2 for each line in hosts.txt.
#       ssh -n "admin@${1}" printf "%s\t%s\n" "$(ipconfig getifaddr en0)" "$(hostname)"
#   }
#
# Connects to every hosts listed in hosts.txt as admin, using their IP address
# (field n.2), runs getNetworkInfo function on them and outputs the results in 
# out.txt :
#
#   runForEach hosts.txt --field 2 getNetworkInfo > ./out.txt
#
# Copy a file (containing a script) to the remote hosts and runs the file on 
# each host :
#
#   function copyScript()
#   {
#       local script="myScript.sh"
#       local remote_path="~"
#
#       scp "${script}" "admin@${1}:${remote_path}"
#   }
#
#   function runScript()
#   {
#       local script_path="~/myScript.sh"
#
#       ssh -T "admin@${1}" << EOF
#           chmod u+x ${script_path}
#           ${script_path}
#           rm ${script_path}
#   EOF
#   }
#
#   runForEach hosts.txt --field 1 copyScript
#   runForEach hosts.txt --field 1 runScript
#
# ------------------------------------------------------------------------------

function runForEach()
{
#Usage
read -r -d '' usage <<-'END_USAGE'
usage: runForEach list_file [--field n] [command]
END_USAGE


    local field=0
    local cmd="echo"

    # Checks
    #[[ $# -lt 1 ]] || { printf "%s\n" "${usage}"; return 1; }

    # Read parameters :
    [[ -f "${1}" ]] && [[ -r "${1}" ]] && { local list_file="${1}"; } || { printf "%s\n" "Could not open file '${1}'. Aborting."; return 1; }

    shift

    if [ "$#" -gt 0 ]
    then
        if [ "$1" = "--field" ]
        then
            if [ "$#" -gt 1 ] && [[ $2 =~ ^[0-9]+$ ]]   # Also check if numeric.
            then
                field=${2}
                shift 2
            else
                printf "%s\n" "Error: you have to specify a field number when using the --field option. Aborting." >&2
                return 1
            fi
        fi

        [[ "$#" -gt 0 ]] && { cmd="$@"; }
    fi

    # Job
    grep -vE "^(\s*$|#)" "${list_file}" | while read -r line
    do
        if [ ${field} -eq 0 ]
        then
            param="${line}"
        else
            param=$(echo "${line}" | unexpand -a | cut -f"${field}")
        fi

        $cmd "${param}"
    done
}

readonly -f runForEach

#EOF
