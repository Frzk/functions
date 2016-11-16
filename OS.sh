#!/bin/bash

# ------------------------------------------------------------------------------
# Function os_family
#
# Retrieves the OS "family" name.
# Possible return values are "OSX", "Linux", "BSD", "Solaris" or "Unknown".
#
#
# Examples
# ========
# Do something depending on the platform :
#
#   platform=$(os_family)
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

function os_family()
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



function is_version()
{
    return $(osx_version | grep -q "^${1}")
}



# ------------------------------------------------------------------------------
# Function osx_version
#
# Retrieves the OSX version (e.g. 10.10.3)
#
#
# Examples
# ========
#
# if [ $(osx_version) \> "10.9" ]
# then
#     # Do something only available on OSX > 10.9
# else
#     # Fallback to another method.
# fi
#
# ------------------------------------------------------------------------------

function osx_version()
{
    printf "%s\n" $(sw_vers -productVersion)
}



# ------------------------------------------------------------------------------
# Function osx_is_SnowLeopard
#
# Tests whether we are running Mac OSX 10.6 (Snow Leopard) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Snow Leopard :
#
#   osx_is_SnowLeopard && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function osx_is_SnowLeopard()
{
    local identifier="10.6"

    return $(osx_version "${identifier}")
}

# ------------------------------------------------------------------------------
# Function osx_is_Lion
#
# Tests whether we are running Mac OSX 10.7 (Lion) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Lion :
#
#   osx_is_Lion && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function osx_is_Lion()
{
    local identifier="10.7"

    return $(osx_version "${identifier}")
}

# ------------------------------------------------------------------------------
# Function osx_is_MountainLion
#
# Tests whether we are running Mac OSX 10.8 (Mountain Lion) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Mountain Lion :
#
#   osx_is_MountainLion && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function osx_is_MountainLion()
{
    local identifier="10.8"

    return $(osx_version "${identifier}")
}

# ------------------------------------------------------------------------------
# Function osx_is_Mavericks
#
# Tests whether we are running Mac OSX 10.9 (Mavericks) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Mavericks :
#
#   osx_is_Mavericks && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function osx_is_Mavericks()
{
    local identifier="10.9"

    return $(osx_version "${identifier}")
}

# ------------------------------------------------------------------------------
# Function osx_is_Yosemite
#
# Tests whether we are running Mac OSX 10.10 (Yosemite) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Yosemite :
#
#   osx_is_Yosemite && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function osx_is_Yosemite()
{
    local identifier="10.10"

    return $(osx_version "${identifier}")
}

# ------------------------------------------------------------------------------
# Function osx_is_ElCapitan
#
# Tests whether we are running Mac OSX 10.11 (El Capitan) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running El Capitan :
#
#   osx_is_ElCapitan && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function osx_is_ElCapitan()
{
    local identifier="10.11"

    return $(osx_version "${identifier}")
}

# ------------------------------------------------------------------------------
# Function osx_is_Sierra
#
# Tests whether we are running Mac OSX 10.12 (Sierra) or not.
#
#
# Examples
# ========
# Outputs "OK" if we are running Sierra :
#
#   osx_is_Sierra && printf "%s\n" "OK"
#
# ------------------------------------------------------------------------------

function osx_is_Sierra()
{
    local identifier="10.12"

    return $(osx_version "${identifier}")
}


readonly -f os_family
readonly -f osx_version
readonly -f osx_is_SnowLeopard
readonly -f osx_is_Lion
readonly -f osx_is_MountainLion
readonly -f osx_is_Mavericks
readonly -f osx_is_Yosemite
readonly -f osx_is_ElCapitan
readonly -f osx_is_Sierra

#EOF
