#!/bin/bash

# ------------------------------------------------------------------------------
# Function getOSFamily
#
# Retrieves the OS "family" name.
# Possible return values are "OSX", "Linux", "BSD", "Solaris" or "Unknown".
#
#
# Examples
# ========
# Do something depending on the platform :
#
#   platform=$(getOSFamily)
#
#   case ${platform} in:
#       OSX)
#           launchctl load /Library/LaunchDaemons/com.example.myservice.plist
#           break
#           ;;
#       Linux)
#           systemctl start com.example.myservice.service
#           break
#           ;;
#       *)
#           break
#           ;;
#   esac
#
# ------------------------------------------------------------------------------

function getOSFamily()
{
    case "${OSTYPE}" in
        darwin*)
            printf "%s\n" "OSX"
            ;;
        linux*)
            printf "%s\n" "Linux"
            ;;
        solaris*)
            printf "%s\n" "Solaris"
            ;;
        bsd*)
            printf "%s\n" "BSD"
            ;;
        *)
            printf "Unknown: %s\n" "${OSTYPE}"
            ;;
    esac
}



function isVersion()
{
    return $(sw_vers -productVersion | grep -q "^${1}")
}



# ------------------------------------------------------------------------------
# Function isSnowLeopard
#
# Tests whether we are running Mac OSX 10.6 (Snow Leopard) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Snow Leopard :
#
#   isSnowLeopard && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function isSnowLeopard()
{
    local identifier="10.6"

    return $(isVersion "${identifier}")
}

# ------------------------------------------------------------------------------
# Function isLion
#
# Tests whether we are running Mac OSX 10.7 (Lion) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Lion :
#
#   isLion && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function isLion()
{
    local identifier="10.7"

    return $(isVersion "${identifier}")
}

# ------------------------------------------------------------------------------
# Function isMountainLion
#
# Tests whether we are running Mac OSX 10.8 (Mountain Lion) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Mountain Lion :
#
#   isMountainLion && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function isMountainLion()
{
    local identifier="10.8"

    return $(isVersion "${identifier}")
}

# ------------------------------------------------------------------------------
# Function isMavericks
#
# Tests whether we are running Mac OSX 10.9 (Mavericks) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Mavericks :
#
#   isMavericks && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function isMavericks()
{
    local identifier="10.9"

    return $(isVersion "${identifier}")
}

# ------------------------------------------------------------------------------
# Function isYosemite
#
# Tests whether we are running Mac OSX 10.10 (Yosemite) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Yosemite :
#
#   isYosemite && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function isYosemite()
{
    local identifier="10.10"

    return $(isVersion "${identifier}")
}



readonly -f getOSFamily
readonly -f isVersion
readonly -f isSnowLeopard
readonly -f isLion
readonly -f isMountainLion
readonly -f isMavericks
readonly -f isYosemite

#EOF
