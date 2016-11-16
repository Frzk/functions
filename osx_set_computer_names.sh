#!/bin/bash

# ------------------------------------------------------------------------------
# Function osx_set_computer_names
#
# Sets all names (ComputerName, HostName, LocalHostName, NetBIOS name) of a 
# computer.
#
# Note : This function does not verify if the given name(s) are allowed or not.
#
#
# Options
# =======
# -q | --quiet  : quiet mode : do not yield.
#
#
# Parameters
# ==========
# name (Req) :
#     Mac computer name.
#
# NetBIOS_name (Opt) :
#     NetBIOS computer name. If the given NetBIOS name is longer than 15 
#     characters, it will be truncated.
#     If omitted, tries to compute it from the given name.
#
#
# Examples
# ========
# Sets the name of the computer to "John-Computer", and its NetBIOS name to 
# "JOHN-COMPUTER" :
#
#   osx_set_computer_names "John-Computer" "JOHN-COMPUTER"
#
# Silently set the name of the computer to "This-Is-A-Long-Name" and its 
# NetBIOS name to "THIS-IS-A-LONG-" :
#
#   osx_set_computer_names --quiet "This-Is-A-Long-Name"
#
# ------------------------------------------------------------------------------

function osx_set_computer_names()
{
#Usage
read -r -d '' usage <<-'END_USAGE'
usage: osx_set_computer_names [-q | --quiet] name [NetBIOS_name]
END_USAGE


    local name="computer"
    local netbios_name="computer"
    local quietMode=false
    
    # Options
    while [ "$#" -gt 0 ]
    do
        case $1 in
            -q|--quiet)
                quietMode=true
                shift
                ;;
            --) # End of all options.
                shift
                break
                ;;
            -?*)
                printf "Unknown option (ignored): %s\n" "$1" >&2
                shift
                ;;
            *)  # Default case: If no more options then break out of the loop.
                break
                ;;
        esac
    done

    # Checks
    case $# in
        1)  name="$1"
            netbios_name=$(echo "${1:0:15}" | tr "[:lower:]" "[:upper:]")
            ;;
        2)  name="$1"
            netbios_name=$(echo "${2:0:15}" | tr "[:lower:]" "[:upper:]")
            ;;
        *)  printf "%s\n" "${usage}" >&2
            return 1
            ;;
    esac

    # Job
    [[ "${quietMode}" = true ]] || printf "%s\n" "Setting ComputerName, HostName and LocalHostName to ${name}."
    scutil --set ComputerName "${name}" || return $?
    scutil --set HostName "${name}" || return $?
    scutil --set LocalHostName "${name}" || return $?
        
    [[ "${quietMode}" = true ]] || printf "%s\n" "Setting NetBIOS name to ${netbios_name}."
    defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${netbios_name}" || return $?
}

readonly -f osx_set_computer_names

#EOF
